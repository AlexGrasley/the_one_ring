import 'package:flutter/material.dart';
import 'package:the_one_ring/Widgets/HeartRatingBoxes.dart';
import 'package:the_one_ring/Widgets/StrenghtRatingBoxes.dart';
import 'package:the_one_ring/Widgets/WitsRatingBoxes.dart';
import '../Repositories/CharacterRepository.dart';
import '../Widgets/TextFormInput.dart';
import '../StateNotifiers/CharacterStateNotifier.dart';
import '../Models/Character.dart';

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
          basicFields(character, characterFormNotifier),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ratingBoxes(context, character, characterFormNotifier),
          ),
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

  Widget ratingBoxes(BuildContext context, Character character, CharacterFormNotifier characterFormNotifier){
    return Column(
      children: [
        Row(
          children: [
            Expanded(
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
            Expanded(
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
            )
          ],
        ),
        SizedBox(
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
        )
      ],
    );
  }

  Widget basicFields(Character character, CharacterFormNotifier characterFormNotifier) {
    return Column(
        children: [Row(
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
          )
        ]);
  }

}