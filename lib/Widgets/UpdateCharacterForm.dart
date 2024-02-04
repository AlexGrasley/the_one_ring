import 'package:flutter/material.dart';
import 'package:the_one_ring/Widgets/CurrentEnduranceBoxes.dart';
import 'package:the_one_ring/Widgets/CurrentHopeBoxes.dart';
import 'package:the_one_ring/Widgets/HeartRatingBoxes.dart';
import 'package:the_one_ring/Widgets/StrenghtRatingBoxes.dart';
import 'package:the_one_ring/Widgets/WitsRatingBoxes.dart';
import '../Repositories/CharacterRepository.dart';
import '../Widgets/TextFormInput.dart';
import '../StateNotifiers/CharacterStateNotifier.dart';
import '../Models/Character.dart';
import 'DiamondShape.dart';

class UpdateCharacterForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final CharacterStateNotifier characterFormNotifier;
  final Character character;

  const UpdateCharacterForm({
    super.key,
    required this.formKey,
    required this.characterFormNotifier,
    required this.character,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(children: [
          Card(
              shadowColor: Colors.blueGrey,
              color: Colors.transparent,
              child: basicFields(context, character, characterFormNotifier)
          ),
          Card(
              shadowColor: Colors.blueGrey,
              color: Colors.transparent,
              child: experienceBoxes(context, character, characterFormNotifier)
          ),
          statBoxes(context, character, characterFormNotifier),
          Card(
            shadowColor: Colors.blueGrey,
            color: Colors.transparent,
            child: conditionsBoxes(context, character, characterFormNotifier)
          ),
          ratingBoxes(context, character, characterFormNotifier),
          ElevatedButton(
            style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
              foregroundColor: MaterialStatePropertyAll(Colors.white)
            ),
            onPressed: () async {
              await saveCharacter(character);
              if(context.mounted){
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: const Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Character Saved!",
                              style: TextStyle(color: Colors.white, fontSize: 26),
                            ),
                          ),
                        ),
                        actions: [
                          TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("Close")
                          )
                        ],
                      );
                    }
                );
              }
            },
            child: const Text('Save Character'),
          )
        ]),
      ),
    );
  }

  Widget conditionsBoxes(BuildContext context, Character character, CharacterStateNotifier characterFormNotifier){
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          characterFormNotifier.updateWeary(!character.weary);
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
                                color: character.weary ? Colors.red : Colors.transparent,
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.circular(character.weary? 10 : 0)
                            ),
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        width: 10,
                      ),
                      const Text("Weary", style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          characterFormNotifier.updateMiserable(!character.miserable);
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
                                color: character.miserable ? Colors.red : Colors.transparent,
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.circular(character.miserable? 10 : 0)
                            ),
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        width: 10,
                      ),
                      const Text("Miserable",style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () async {
                          characterFormNotifier.updateWounded(!character.wounded);
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
                                color: character.wounded ? Colors.red : Colors.transparent,
                                border: Border.all(color: Colors.red),
                                borderRadius: BorderRadius.circular(character.wounded? 10 : 0)
                            ),
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        width: 10,
                      ),
                      const Text("Wounded",style: TextStyle(color: Colors.white))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormInput(
                initialValue: character.injury,
                labelText: "Injury",
                onChanged: characterFormNotifier.updateInjury),
          ),
        )
      ],
    );
  }

  Widget experienceBoxes(BuildContext context, Character character, CharacterStateNotifier characterFormNotifier){
    return
      InkWell(
        onTap: () => _showStatUpdateDialog(
          context,
          character,
          "Update Experience",
          "Adventure Points",
          character.adventurePoint.toString(),
          "Skill Points",
          character.skillPoints.toString(),
          "Fellowship Score",
          character.fellowshipScore.toString(),
          characterFormNotifier.updateAdventurePoint,
          characterFormNotifier.updateSkillPoints,
          characterFormNotifier.updateFellowshipScore
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  const Text("Adventure", style: TextStyle(fontSize: 18, color: Colors.red)),
                  const Text("Points", style: TextStyle(fontSize: 18, color: Colors.red)),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child:
                      DiamondShape(character.adventurePoint.toString(), "", size: 50,drawSecondLine: false)
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const Text("Skill", style: TextStyle(fontSize: 18, color: Colors.red)),
                  const Text("Points", style: TextStyle(fontSize: 18, color: Colors.red)),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child:
                      DiamondShape(character.skillPoints.toString(), "", size: 50,drawSecondLine: false)
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const Text("Fellowship", style: TextStyle(fontSize: 18, color: Colors.red)),
                  const Text("Score", style: TextStyle(fontSize: 18, color: Colors.red)),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child:
                      DiamondShape(character.fellowshipScore.toString(), "", size: 50,drawSecondLine: false)
                  ),
                ],
              ),
            ),
          ],
        ),
    );
  }

  Widget statBoxes(BuildContext context, Character character, CharacterStateNotifier characterFormNotifier){
    return
        Row(
          children: [
            Expanded(
              child:
              InkWell(
                onTap: () =>
                    _showStatUpdateDialog(
                        context,
                        character,
                        "Update Endurance Stats",
                        "Current Endurance",
                        character.currentEndurance.toString(),
                        "Load",
                        character.load.toString(),
                        "Fatigue",
                        character.fatigue.toString(),
                        characterFormNotifier.updateCurrentEndurance,
                        characterFormNotifier.updateLoad,
                        characterFormNotifier.updateFatigue
                    ),
                child: Card(
                    shadowColor: Colors.blueGrey,
                    color: Colors.transparent,
                    child:
                    Column(
                      children: [
                        const Text("Endurance", style: TextStyle(color: Colors.red, fontSize: 18),),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(3,3,25,3),
                          child: CurrentEnduranceRatingBoxes(character),
                        ),
                      ],
                    )
                ),
              ),
            ),
            Expanded(
              child:
              InkWell(
                onTap: () =>
                    _showStatUpdateDialog(
                        context,
                        character,
                        "Update Hope States",
                        "Current Hope",
                        character.currentHope.toString(),
                        "Shadow",
                        character.shadow.toString(),
                        "Shadow Scars",
                        character.shadowScars.toString(),
                        characterFormNotifier.updateCurrentHope,
                        characterFormNotifier.updateShadow,
                        characterFormNotifier.updateShadowScars
                    ),
                child: Card(
                  shadowColor: Colors.blueGrey,
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      const Text("Heart", style: TextStyle(color: Colors.red, fontSize: 18),),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(3,3,25,3),
                        child: CurrentHopeRatingBoxes(character),
                      ),
                    ],
                  ),
                ),
              ),
            )
      ],
    );
  }

  Widget ratingBoxes(BuildContext context, Character character, CharacterStateNotifier characterFormNotifier){
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child:
                InkWell(
                  onTap: () =>
                    _showStatUpdateDialog(
                      context,
                      character,
                      "Update Strength",
                      "Strength Target Number",
                      character.strengthTn.toString(),
                      "Strength Rating",
                      character.strengthRating.toString(),
                      "Endurance",
                      character.endurance.toString(),
                      characterFormNotifier.updateStrengthTn,
                      characterFormNotifier.updateStrengthRating,
                      characterFormNotifier.updateEndurance
                  ),
                  child: Card(
                      shadowColor: Colors.blueGrey,
                      color: Colors.transparent,
                    child:
                        Column(
                          children: [
                            const Text("strength", style: TextStyle(color: Colors.red, fontSize: 18),),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(3,3,25,3),
                              child: StrengthRatingBoxes(character),
                            ),
                          ],
                        )
                  ),
                ),
              ),
            Expanded(
              child:
              InkWell(
                onTap: () =>
                  _showStatUpdateDialog(
                    context,
                    character,
                    "Update Heart",
                    "Heart Target Number",
                    character.heartTn.toString(),
                    "Heart Rating",
                    character.heartRating.toString(),
                    "Hope",
                    character.hope.toString(),
                    characterFormNotifier.updateHeartTn,
                    characterFormNotifier.updateHeartRating,
                    characterFormNotifier.updateHope
                  ),
                child: Card(
                  shadowColor: Colors.blueGrey,
                  color: Colors.transparent,
                  child: Column(
                    children: [
                      const Text("heart", style: TextStyle(color: Colors.red, fontSize: 18),),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(3,3,25,3),
                        child: HeartRatingBoxes(character),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        InkWell(
          onTap: () =>
            _showStatUpdateDialog(
              context,
              character,
              "Update Wits",
              "Wits Target Number",
              character.witsTn.toString(),
              "Wits Rating",
              character.witsRating.toString(),
              "Parry",
              character.parry.toString(),
              characterFormNotifier.updateWitsTn,
              characterFormNotifier.updateWitsRating,
              characterFormNotifier.updateParry
            ),
          child: SizedBox(
            width: 225,
            child: Card(
              shadowColor: Colors.blueGrey,
              color: Colors.transparent,
              child: Column(
                children: [
                  const Text("wits", style: TextStyle(color: Colors.red, fontSize: 18),),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(3,3,25,3),
                    child: WitsRatingBoxes(character),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget basicFields(BuildContext context, Character character, CharacterStateNotifier characterFormNotifier) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormInput(
                  initialValue: character.name,
                  labelText: 'Name',
                  onChanged: (value) {
                    characterFormNotifier.updateName(value);
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormInput(
                  initialValue: character.heroicCulture,
                  labelText: 'Heroic Culture',
                  onChanged: (value) {
                    characterFormNotifier.updateHeroicCulture(value);
                  },
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormInput(
                  initialValue: character.culturalBlessing,
                  labelText: 'Cultural Blessing',
                  onChanged: (value) {
                    characterFormNotifier.updateCulturalBlessing(value);
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormInput(
                  initialValue: character.patron,
                  labelText: 'Patron',
                  onChanged: (value) {
                    characterFormNotifier.updatePatron(value);
                  },
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormInput(
                  initialValue: character.calling,
                  labelText: 'Calling',
                  onChanged: (value) {
                    characterFormNotifier.updateCalling(value);
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormInput(
                  initialValue: character.shadowPath,
                  labelText: 'Shadow Path',
                  onChanged: (value) {
                    characterFormNotifier.updateShadowPath(value);
                  },
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormInput(
                  initialValue: character.distinctiveFeatures,
                  labelText: 'Distinctive Features',
                  onChanged: (value) {
                    characterFormNotifier.updateDistinctiveFeatures(value);
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormInput(
                  initialValue: character.flaws,
                  labelText: 'Flaws',
                  onChanged: (value) {
                    characterFormNotifier.updateFlaws(value);
                  },
                ),
              ),
            ),
          ],
        )
      ]);
  }

  Future<void> _showStatUpdateDialog(
      BuildContext context,
      Character character,
      String title,
      String targetNumberLabel,
      String targetNumberInitValue,
      String ratingLabel,
      String ratingInitValue,
      String otherLabel,
      String otherInitValue,
      Function(int) updateTargetNumber,
      Function(int) updateRating,
      Function(int) updateOther) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text(title, style: const TextStyle(color: Colors.white)),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  TextFormInput(
                      initialValue: targetNumberInitValue,
                      labelText: targetNumberLabel,
                      isNumberEntry: true,
                      onChanged: (value) {
                        updateTargetNumber(int.parse(value));
                      }
                  ),
                  TextFormInput(
                      initialValue: ratingInitValue,
                      labelText: ratingLabel,
                      isNumberEntry: true,
                      onChanged: (value) {
                        updateRating(int.parse(value));
                      }
                  ),
                  TextFormInput(
                      initialValue: otherInitValue,
                      labelText: otherLabel,
                      isNumberEntry: true,
                      onChanged: (value) {
                        updateOther(int.parse(value));
                      }
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Update'),
                onPressed: () {
                  // update logic here
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                }
           )]);
      });
    }

  Future saveCharacter(Character character) async{
    if (formKey.currentState!.validate()) {
      final repository = await CharacterRepository.getInstance();

      character = await repository.updateCharacter(character);
    }
  }

}
