import 'package:flutter/material.dart';
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormInput(
              initialValue: character.name,
              labelText: 'Name',
              onChanged: (value) {
                characterFormNotifier.updateName(value);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormInput(
              initialValue: character.heroicCulture,
              labelText: 'Heroic Culture',
              onChanged: (value) {
                characterFormNotifier.updateHeroicCulture(value);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormInput(
              initialValue: character.culturalBlessing,
              labelText: 'Cultural Blessing',
              onChanged: (value) {
                characterFormNotifier.updateCulturalBlessing(value);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormInput(
              initialValue: character.patron,
              labelText: 'Patron',
              onChanged: (value) {
                characterFormNotifier.updatePatron(value);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormInput(
              initialValue: character.calling,
              labelText: 'Calling',
              onChanged: (value) {
                characterFormNotifier.updateCalling(value);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormInput(
              initialValue: character.shadowPath,
              labelText: 'Shadow Path',
              onChanged: (value) {
                characterFormNotifier.updateShadowPath(value);
              },
            ),
          ),
          Builder(
              builder: (context) {
                return ElevatedButton(
                  onPressed: () async {
                    await saveCharacter(character);
                    if (context.mounted){
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('Save Character'),
                );
              }
          ),
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

}