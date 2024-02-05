import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_one_ring/Helpers/Utilities.dart';
import 'package:the_one_ring/Models/Armour.dart';
import 'package:the_one_ring/Models/Character.dart';
import 'package:the_one_ring/Models/CombatProficiencies.dart';
import 'package:the_one_ring/Models/Skills.dart';
import 'package:the_one_ring/Repositories/ArmourRepository.dart';
import 'package:the_one_ring/Repositories/CharacterRepository.dart';
import 'package:the_one_ring/Repositories/CombatProficienciesRepository.dart';
import 'package:the_one_ring/Repositories/WeaponRepository.dart';
import 'package:the_one_ring/StateNotifiers/CharacterStateNotifier.dart';
import 'package:the_one_ring/StateNotifiers/CombatProfStateNotifier.dart';
import 'package:the_one_ring/Widgets/LabeledDivider.dart';
import 'package:the_one_ring/Widgets/TextFormInput.dart';

import '../Models/Weapon.dart';
import '../StateNotifiers/ArmourStateNotifier.dart';
import '../StateNotifiers/WeaponStateNotifier.dart';

// Create a provider for SkillsRepository.
final combatProfRepositoryProvider = Provider((ref) => CombatProficienciesRepository.getInstance());
// Create a provider for CharacterRepository.
final characterRepositoryProvider = Provider((ref) => CharacterRepository.getInstance());

final armourRepositoryProvider = Provider((ref) => ArmourRepository.getInstance());

final weaponRepositoryProvider = Provider((ref) => WeaponRepository.getInstance());

final combatProfStateNotifierProviderFamily = FutureProvider.family<CombatProfStateNotifier, int>((ref, characterId) async {
  final characterRepository = await ref.watch(characterRepositoryProvider);
  final combatProfs = characterRepository.getCharacterCombatProfs(characterId);

  return CombatProfStateNotifier(combatProfs ?? []);
});

final weaponsStateNotifierProviderFamily = FutureProvider.family<WeaponStateNotifier, int>((ref, characterId) async {
  final characterRepository = await ref.watch(characterRepositoryProvider);
  final weapons = characterRepository.getCharacterWeapons(characterId);

  return WeaponStateNotifier(weapons ?? []);
});

final armourStateNotifierProviderFamily = FutureProvider.family<ArmourStateNotifier, int>((ref, characterId) async {
  final characterRepository = await ref.watch(characterRepositoryProvider);
  final armour = characterRepository.getCharacterArmour(characterId);

  return ArmourStateNotifier(armour ?? []);
});

final combatProfsStateNotifierProvider = StateNotifierProvider.autoDispose.family<CombatProfStateNotifier, List<CombatProficiencies>, Character>((ref, character) {
  return CombatProfStateNotifier(character.combatProficiencies);
});

final weaponsStateNotifierProvider = StateNotifierProvider.autoDispose.family<WeaponStateNotifier, List<Weapon>, Character>((ref, character) {
  return WeaponStateNotifier(character.weapons);
});

final armourStateNotifierProvider = StateNotifierProvider.autoDispose.family<ArmourStateNotifier, List<Armour>, Character>((ref, character) {
  return ArmourStateNotifier(character.armour);
});

class CombatDataForm extends ConsumerStatefulWidget {

  CombatDataForm(this._character, {Key? key}) : super(key: key);

  final Character _character;

  @override
  _CombatDataFormState createState() => _CombatDataFormState();
}


class _CombatDataFormState extends ConsumerState<CombatDataForm> {
  late Future<List<Skill>?> skills;
  SkillClass? currentSkillClass;

  CombatDataForm(this.character, {super.key});

  @override
  Widget build(BuildContext context) {

    final combatProfs = ref.watch(combatProfsStateNotifierProvider(widget._character));
    final combatProfFormProvider = ref.read(combatProfsStateNotifierProvider(widget._character).notifier);

    final character = ref.watch(characterStateProvider(widget._character));
    final characterFormNotifier = ref.watch(characterStateProvider(widget._character).notifier);

    final weapons = character.weapons;
    final weaponsFormProvider = ref.read(weaponsStateNotifierProvider(widget._character).notifier);

    final armour = character.armour;
    final armourFormProvider = ref.read(armourStateNotifierProvider(widget._character).notifier);

    return SingleChildScrollView(
        child: Column(
          children: [
            const LabeledDivider(
              label: "Combat Proficiency",
              value: '',
            ),
            Column(
              children: combatProfs.asMap().entries.map<Widget>((entry) {

                int index = entry.key;
                CombatProficiencies combatProf = entry.value;

                return _buildRow(context, ref, index, combatProf, combatProfFormProvider);

              }).toList(),
            ),
            const LabeledDivider(
                label: "Weapons",
                value: ""
            ),
            Column(
              children:
              weapons.asMap().entries.map<Widget>((entry) {

                int index = entry.key;
                Weapon weapon = entry.value;

                return _buildWeaponRow(context, ref, index, weapon, weaponsFormProvider);

              }).toList(),
            ),
            ElevatedButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey)
                ),
                onPressed: () => {
                  _showAddWeaponAlert(context, ref, widget._character, weaponRepositoryProvider,characterFormNotifier)
                },
                child: const Icon(FontAwesomeIcons.circlePlus, color: Colors.white)
            ),
            const LabeledDivider(
                label: "Armour",
                value: ""
            ),
            Column(
              children:
                armour.asMap().entries.map<Widget>((entry) {

                  int index = entry.key;
                  Armour armour = entry.value;

                  return _buildArmourRow(context, ref, index, armour);

                }).toList(),
              ),
            ElevatedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.blueGrey)
                ),
                onPressed: () => {
                  _showAddArmourAlert(context, ref, widget._character, armourRepositoryProvider,characterFormNotifier)
                },
                child: const Icon(FontAwesomeIcons.circlePlus, color: Colors.white)
            ),
            ],
          )
        );
    }

  Widget _buildRow(BuildContext context, WidgetRef ref,int index, CombatProficiencies combatProf, CombatProfStateNotifier combatProfFormProvider){
    return Container(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
           Expanded( // Add Expanded widget here
              child: Column(
                children: [
                  Text(
                    combatProf.name,
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
                var results = rollDice(combatProf);
                showDiceResults(context, results, widget._character, combatProf);
              },
              child: const Icon(FontAwesomeIcons.diceD20, color: Colors.blueGrey)
          ),
          const SizedBox(width: 5),
          Expanded( // Wrap Row with Expanded to make the boxes take the remaining space in the row
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start, // Align boxes to the right
              children: List.generate(6, (combatProfIndex) {
                return Transform.rotate( // add Transform.rotate widget
                  angle: pi / 4, // rotate 45 degrees
                  child: InkWell(
                    onTap: () async {
                      combatProfFormProvider.updateProficiency(
                          combatProf.id,
                          combatProf.proficiency == 1 &&
                              combatProfIndex == 0 ?
                              0 :
                              combatProfIndex + 1);
                      var repo = await ref.watch(combatProfRepositoryProvider);
                      repo.updateProficiency(combatProf);
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
                            color: combatProfIndex < combatProf.proficiency ? Colors.redAccent : Colors.transparent,
                            border: Border.all(color: Colors.red), // add color red to borders
                            borderRadius: combatProfIndex < combatProf.proficiency ? BorderRadius.circular(10) : BorderRadius.circular(0)
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

  Future<void> _showAddWeaponAlert(
      BuildContext context,
      WidgetRef ref,
      Character character,
      Provider<Future<WeaponRepository>> weaponRepositoryProvider,
      CharacterStateNotifier characterStateNotifier) async
  {

    var repo = await ref.watch(weaponRepositoryProvider);
    List<Weapon> masterWeaponsList = repo.getMasterWeaponsList();

    if(context.mounted) {
      Weapon? selectedWeapon;

      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(  // adding StatefulBuilder
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                title: const Text('Add a weapon', style: TextStyle(color: Colors.blueGrey)),
                content: DropdownButton<Weapon>(
                  hint: const Text('Select a weapon', style: TextStyle(color: Colors.blueGrey)),
                  value: selectedWeapon,
                  onChanged: (Weapon? value) {
                    setState(() {  // It will now work
                      selectedWeapon = value;
                    });
                  },
                  items: masterWeaponsList.map((Weapon weapon) {
                    return DropdownMenuItem<Weapon>(
                      value: weapon,
                      child: Text(weapon.name, style: const TextStyle(color: Colors.blueGrey)),
                    );
                  }).toList(),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancel', style: TextStyle(color: Colors.blueGrey)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('OK', style: TextStyle(color: Colors.red)),
                    onPressed: () async {
                      if (selectedWeapon != null) {
                        character.weapons.add(selectedWeapon!);
                        var repo = await ref.watch(characterRepositoryProvider);
                        repo.updateCharacter(character);
                        characterStateNotifier.updateWeapons(character.weapons);
                      }
                      if(context.mounted){
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              );
            },
          );
        },
      );
    }
  }

  Future<void> _showAddArmourAlert(
      BuildContext context,
      WidgetRef ref,
      Character character,
      Provider<Future<ArmourRepository>> armourRepositoryProvider,
      CharacterStateNotifier characterStateNotifier) async
  {

    var repo = await ref.watch(armourRepositoryProvider);
    List<Armour> masterArmourList = repo.getMasterArmourList();

    if(context.mounted) {
      Armour? selectedArmour;

      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(  // adding StatefulBuilder
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                title: const Text('Add armour', style: TextStyle(color: Colors.blueGrey)),
                content: DropdownButton<Armour>(
                  hint: const Text('Select armour', style: TextStyle(color: Colors.blueGrey)),
                  value: selectedArmour,
                  onChanged: (Armour? value) {
                    setState(() {  // It will now work
                      selectedArmour = value;
                    });
                  },
                  items: masterArmourList.map((Armour armour) {
                    return DropdownMenuItem<Armour>(
                      value: armour,
                      child: Text(armour.name, style: const TextStyle(color: Colors.blueGrey)),
                    );
                  }).toList(),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancel', style: TextStyle(color: Colors.blueGrey)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('OK', style: TextStyle(color: Colors.red)),
                    onPressed: () async {
                      if (selectedArmour != null) {
                        character.armour.add(selectedArmour!);
                        var repo = await ref.watch(characterRepositoryProvider);
                        repo.updateCharacter(character);
                        characterStateNotifier.updateArmour(character.armour);
                      }
                      if(context.mounted){
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              );
            },
          );
        },
      );
    }
  }

}


Widget _buildWeaponRow(BuildContext context, WidgetRef ref, int index, Weapon weapon, WeaponStateNotifier weaponsFormProvider) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Material(
      borderRadius: BorderRadius.circular(10.0),
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildPropertyColumn(
              "",
              weapon.name,
            ),
            buildPropertyColumn(
              'Damage',
              weapon.damage.toString(),
            ),
            buildPropertyColumn(
              'Injury',
              weapon.injury.toString(),
            ),
            buildPropertyColumn(
              'Load',
              weapon.load.toString(),
            ),
          ],
        ),
      ),
    ),
  );


    Row(
    children: [
      Text(weapon.name, style: const TextStyle(color: Colors.blueGrey)),
      Text(weapon.damage.toString(), style: const TextStyle(color: Colors.blueGrey)),
      Text(weapon.injury.toString(), style: const TextStyle(color: Colors.blueGrey)),
      Text(weapon.load.toString(), style: const TextStyle(color: Colors.blueGrey)),
      Text(weapon.note, style: const TextStyle(color: Colors.blueGrey)),
    ],
  );
}

Widget _buildArmourRow(BuildContext context, WidgetRef ref, int index, Armour armour) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Material(
      borderRadius: BorderRadius.circular(10.0),
      elevation: 3.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildPropertyColumn(
                armour.armourType.toString(),
                armour.name,
            ),
            buildPropertyColumn(
              armour.armourType == ArmourType.shield.toString() ? 'Parry' : 'Protection',
              armour.armourType == ArmourType.shield.toString() ? armour.parry.toString() : armour.protection.toString(),
            ),
            buildPropertyColumn(
              'Load',
              armour.load.toString(),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget buildPropertyColumn(String header, String content) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        header,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.underline,
          color: Colors.blueGrey
        ),
      ),
      Text(
        content,
        style: const TextStyle(color: Colors.blueGrey),
      ),
    ],
  );
}

Map<String, int> rollDice(CombatProficiencies combatProficiencies) {
  var rng = Random();
  int d12Result = rng.nextInt(12) + 1;
  int d6Result = combatProficiencies.proficiency * (rng.nextInt(6) + 1);

  return {"D12 Result": d12Result, "D6 Result": d6Result};
}

void showDiceResults(BuildContext context, Map<String, int> results, Character character, CombatProficiencies combatProf) {

  var total = results.values.reduce((value1, value2) => value1 + value2);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.55), // Or any other value according to preference
            child: AlertDialog(
              title: const Center(child: Text('Results')),
              content:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: results.entries.map((e) => Text('${e.key}: ${e.value}')).toList(),
                  ),
                  const SizedBox(height: 10),
                  Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Text(total.toString(), style: const TextStyle(fontSize: 26, color: Colors.white))
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