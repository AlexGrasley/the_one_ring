import 'package:flutter/material.dart';
import 'package:the_one_ring/Widgets/CurrentEnduranceBoxes.dart';
import 'package:the_one_ring/Widgets/CurrentHopeBoxes.dart';
import 'package:the_one_ring/Widgets/HeartRatingBoxes.dart';
import 'package:the_one_ring/Widgets/StrenghtRatingBoxes.dart';
import 'package:the_one_ring/Widgets/WitsRatingBoxes.dart';
import '../Helpers/DiamondShapePainter.dart';
import '../Repositories/CharacterRepository.dart';
import '../Widgets/TextFormInput.dart';
import '../StateNotifiers/CharacterStateNotifier.dart';
import '../Models/Character.dart';
import 'DiamondShape.dart';

class UpdateCharacterForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final CharacterFormNotifier characterFormNotifier;
  final Character character;
  bool isNewCharacter = false;

  UpdateCharacterForm({
    Key? key,
    required this.formKey,
    required this.characterFormNotifier,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(children: [
          Card(
            color: Theme.of(context).cardColor,
              child: basicFields(character, characterFormNotifier)
          ),
          Card(
              color: Theme.of(context).cardColor,
              child: experienceBoxes(context, character, characterFormNotifier)
          ),
          statBoxes(context, character, characterFormNotifier),
          ratingBoxes(context, character, characterFormNotifier),
          ElevatedButton(
            onPressed: () async {
              await saveCharacter(character);
              if (context.mounted){
                Navigator.of(context).pop();
              }
            },
            child: const Text('Save Character'),
          )
        ]),
      ),
    );
  }

  Widget experienceBoxes(BuildContext context, Character character, CharacterFormNotifier characterFormNotifier){
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
                  const Text("Adventure", style: TextStyle(fontSize: 18)),
                  const Text("Points", style: TextStyle(fontSize: 18)),
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
                  const Text("Skill", style: TextStyle(fontSize: 18)),
                  const Text("Points", style: TextStyle(fontSize: 18)),
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
                  const Text("Fellowship", style: TextStyle(fontSize: 18)),
                  const Text("Score", style: TextStyle(fontSize: 18)),
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

  Widget statBoxes(BuildContext context, Character character, CharacterFormNotifier characterFormNotifier){
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
                    shadowColor: Colors.grey,
                    color: Theme.of(context).cardColor,
                    child:
                    Column(
                      children: [
                        const Text("Current", style: TextStyle(color: Colors.red, fontSize: 14),),
                        const Text("Endurance", style: TextStyle(color: Colors.red, fontSize: 14),),
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
                  shadowColor: Colors.grey,
                  color: Theme.of(context).cardColor,
                  child: Column(
                    children: [
                      const Text("heart", style: TextStyle(color: Colors.red, fontSize: 24),),
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

  Widget ratingBoxes(BuildContext context, Character character, CharacterFormNotifier characterFormNotifier){
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
                    shadowColor: Colors.grey,
                    color: Theme.of(context).cardColor,
                    child:
                        Column(
                          children: [
                            const Text("strength", style: TextStyle(color: Colors.red, fontSize: 24),),
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
                  shadowColor: Colors.grey,
                  color: Theme.of(context).cardColor,
                  child: Column(
                    children: [
                      const Text("heart", style: TextStyle(color: Colors.red, fontSize: 24),),
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
              shadowColor: Colors.grey,
              color: Theme.of(context).cardColor,
              child: Column(
                children: [
                  const Text("wits", style: TextStyle(color: Colors.red, fontSize: 24),),
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

  Widget basicFields(Character character, CharacterFormNotifier characterFormNotifier) {
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
            title: Text(title),
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

      if (isNewCharacter){
        character = await repository.addCharacter(character);
      }
      else {
        character = await repository.updateCharacter(character);
      }
    }
  }

}
