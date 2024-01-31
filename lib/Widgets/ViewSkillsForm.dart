import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_one_ring/Models/Character.dart';
import 'package:the_one_ring/Models/Skills.dart';
import 'package:the_one_ring/Repositories/CharacterRepository.dart';
import 'package:the_one_ring/Repositories/SkillsRepository.dart';
import 'package:the_one_ring/StateNotifiers/SkillStateNotifier.dart';


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

  ViewSkillsForm(this.character, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // Have the repository provided here.
    final skillFormProvider = ref.read(skillStateNotifierProvider(character).notifier);
    final skills = Future.value(ref.watch(skillStateNotifierProvider(character)));

    return FutureBuilder<List<Skill>>(
      future: skills,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Failed to load skills'));
        } else if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final skill = snapshot.data![index];
              return Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Transform.rotate(
                      angle: pi / 4,
                      child: InkWell(
                        onTap: () async {
                          skillFormProvider.updateFavored(skill.id, !skill.isFavored);
                          var repo = await ref.watch(skillsRepositoryProvider);
                          repo.updateSkill(skill);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: skill.isFavored ? Colors.redAccent : Colors.transparent,
                            border: Border.all(color: Colors.red),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded( // Add Expanded widget here
                      child: Column(
                        children: [
                          Text(
                            skill.name, // use TextDecoration.underline to underline the text
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
                        RollDice(skill);
                      },
                        child: const Icon(Icons.diamond_rounded)
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
                                skillFormProvider.updatePips(skill.id, pipIndex + 1);
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 5),
                                width: 15,
                                height: 15,
                                decoration: BoxDecoration(
                                  color: pipIndex < skill.pips ? Colors.redAccent : Colors.transparent,
                                  border: Border.all(color: Colors.red), // add color red to borders
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
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

void RollDice(Skill skill) {

  print("dice was rolled!");

}