import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_one_ring/Helpers/Utilities.dart';
import 'package:the_one_ring/Models/Character.dart';
import 'package:the_one_ring/Models/Skills.dart';
import 'package:the_one_ring/Repositories/CharacterRepository.dart';
import 'package:the_one_ring/Repositories/SkillsRepository.dart';
import 'package:the_one_ring/StateNotifiers/SkillStateNotifier.dart';
import 'package:the_one_ring/Widgets/DiamondShape.dart';
import 'package:the_one_ring/Widgets/LabeledDivider.dart';


// Create a provider for SkillsRepository.
final skillsRepositoryProvider = Provider((ref) => SkillsRepository.getInstance());
// Create a provider for CharacterRepository.
final characterRepositoryProvider = Provider((ref) => CharacterRepository.getInstance());

final skillStateNotifierProviderFamily = FutureProvider.family<SkillStateNotifier, int>((ref, characterId) async {
  final characterRepository = await ref.watch(characterRepositoryProvider);
  final skills = characterRepository.getCharacterSkills(characterId);

  return SkillStateNotifier(skills ?? []);
});

final skillStateNotifierProvider = StateNotifierProvider.autoDispose.family<SkillStateNotifier, List<Skill>, Character>((ref, character) {
  return SkillStateNotifier(character.skills);
});


class ViewSkillsForm extends ConsumerWidget {
  final Character character;
  late Future<List<Skill>?> skills;
  SkillClass? currentSkillClass;

  ViewSkillsForm(this.character, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // Have the repository provided here.
    final skills = ref.watch(skillStateNotifierProvider(character));

    return SingleChildScrollView(
        child: Column(
          children: skills.asMap().entries.map<Widget>((entry) {

            int index = entry.key;
            Skill skill = entry.value;
            String skillClassName;
            int targetNumber;

            final skillFormProvider = ref.read(skillStateNotifierProvider(character).notifier);

            if(currentSkillClass == null || Utilities.enumFromString<SkillClass>(SkillClass.values, skill.skillClass) != currentSkillClass){
              currentSkillClass = Utilities.enumFromString<SkillClass>(SkillClass.values, skill.skillClass);

              switch (currentSkillClass){
                case SkillClass.strength:
                  skillClassName = "Strength";
                  targetNumber = character.strengthTn;
                  break;
                case SkillClass.heart:
                  skillClassName = "Heart";
                  targetNumber = character.heartTn;
                  break;
                case SkillClass.wits:
                  skillClassName = "Wits";
                  targetNumber = character.witsTn;
                  break;
                case null:
                  skillClassName = "";
                  targetNumber = 0;
              }

              return Column(
                children: [
                  LabeledDivider(
                    label: skillClassName ,
                    value: targetNumber.toString(),
                  ),
                  _buildRow(context, ref, index, skill, skillFormProvider),
                ],
              );
            }

            return _buildRow(context, ref, index, skill, skillFormProvider);
          }).toList(),
      )
    );
  }

  Widget _buildRow(BuildContext context, WidgetRef ref,int index, Skill skill, SkillStateNotifier skillFormProvider){
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          InkWell(
            onTap: () async {
              skillFormProvider.updateFavored(skill.id, !skill.isFavored);
              var repo = await ref.watch(skillsRepositoryProvider);
              repo.updateSkill(skill);
            },
            child: Container(
              padding: const EdgeInsets.all(1),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
              ),
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                    color: skill.isFavored ? Colors.red : Colors.transparent,
                    border: Border.all(color: Colors.red),
                    borderRadius: BorderRadius.circular(skill.isFavored? 10 : 0)
                ),
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded( // Add Expanded widget here
              child: Column(
                children: [
                  Text(
                    skill.name,
                    style: const TextStyle(color: Colors.blueGrey),// use TextDecoration.underline to underline the text
                  ),
                  const Divider(
                    color: Colors.redAccent,
                    thickness: 1,
                  )
                ],
              )
          ),
          const SizedBox(width: 5),
          InkWell(
              onTap: () {
                var results = rollDice(skill);
                showDiceResults(context, results, character, skill);
              },
              child: const Icon(FontAwesomeIcons.diceD20, color: Colors.blueGrey,)
          ),
          const SizedBox(width: 5),
          Expanded( // Wrap Row with Expanded to make the boxes take the remaining space in the row
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start, // Align boxes to the right
              children: List.generate(6, (pipIndex) {
                return Transform.rotate( // add Transform.rotate widget
                  angle: pi / 4, // rotate 45 degrees
                  child: InkWell(
                    onTap: () async {
                      skillFormProvider.updatePips(
                          skill.id,
                          skill.pips == 1 &&
                              pipIndex == 0 ?
                              0 :
                              pipIndex + 1
                      );
                      var repo = await ref.watch(skillsRepositoryProvider);
                      repo.updateSkill(skill);
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      padding: const EdgeInsets.all(2),
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.red), // add color red to borders
                      ),
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                            color: pipIndex < skill.pips ? Colors.redAccent : Colors.transparent,
                            border: Border.all(color: Colors.red), // add color red to borders
                            borderRadius: pipIndex < skill.pips ? BorderRadius.circular(10) : BorderRadius.circular(0)
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

}





Map<String, dynamic> rollDice(Skill skill) {
  var rng = Random();
  int d12Result = skill.isFavored ? max(rng.nextInt(12) + 1, rng.nextInt(12) + 1)  : rng.nextInt(12) + 1;
  int d6Result = 0;
  bool greatSuccess = false;

  for(var i = 0; i < skill.pips; i++){
    var result = rng.nextInt(6) + 1;
    if (result == 6){
      greatSuccess = true;
    }
    d6Result += result;
  }

  return {"D12 Result": d12Result, "D6 Result": d6Result, "GreatSuccess": greatSuccess};
}

void showDiceResults(BuildContext context, Map<String, dynamic> results, Character character, Skill skill) {

  var targetNumber = getTargetNumber(character, skill);
  var passed = false;
  var total = 0;
  var greatSuccess = results["GreatSuccess"] as bool;

  for(var result in results.values){
    if(result is int){
      total += result;
    }
  }

  passed = total >= targetNumber.targetNumber;


  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.55), // Or any other value according to preference
            child: AlertDialog(
              title: const Center(child: Text('Results', style: TextStyle(color: Colors.white))),
              content:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        targetNumber.name,
                        style: const TextStyle(fontSize: 36, color: Colors.white),
                      ),
                      DiamondShape(targetNumber.targetNumber.toString(),"", size: 75),
                      const SizedBox(height: 10),
                      Column(
                        children: results.entries
                            .where((element) => element.key != "GreatSuccess")
                            .map((e) =>
                            Text('${e.key}: ${e.value}',
                                style: const TextStyle(color: Colors.white)
                            ))
                            .toList(),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: passed? Colors.green : Colors.red,
                          borderRadius: const BorderRadius.all(Radius.circular(10))
                        ),
                        child: passed?
                          Text((greatSuccess? "Great Success!" : "Success"), style: const TextStyle(fontSize: 26, color: Colors.white)) :
                          const Text("Failed!", style: TextStyle(fontSize: 26, color: Colors.black))
                      )
                    ],
                  ),
              actions: [
                ElevatedButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          )
      );
    },
  );
}

TargetNumber getTargetNumber(Character character, Skill skill){
  switch (Utilities.enumFromString(SkillClass.values, skill.skillClass)){
    case SkillClass.strength:
      return TargetNumber("Strength", character.strengthTn);
    case SkillClass.heart:
      return TargetNumber("Heart", character.heartTn);
    case SkillClass.wits:
      return TargetNumber("Wits", character.witsTn);
  }
}

class TargetNumber {
  final String name;
  final int targetNumber;

  TargetNumber(this.name, this.targetNumber);
}