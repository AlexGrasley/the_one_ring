import 'package:flutter/material.dart';
import '../Repositories/CharacterRepository.dart';
import '../StateNotifiers/CharacterStateNotifier.dart';
import '../Models/Character.dart';
import '../Widgets/BasicFields.dart';
import '../Widgets/ConditionsBoxes.dart';
import '../Widgets/ExperienceBoxes.dart';
import '../Widgets/RatingBoxes.dart';
import '../Widgets/StatBoxes.dart';

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
              child: BasicFields(context: context, character: character, characterFormNotifier: characterFormNotifier)
          ),
          Card(
              shadowColor: Colors.blueGrey,
              color: Colors.transparent,
              child: ExperienceBoxes(context: context, character: character, characterFormNotifier: characterFormNotifier)
          ),
          StatBoxes(context: context, character: character, characterFormNotifier: characterFormNotifier),
          Card(
            shadowColor: Colors.blueGrey,
            color: Colors.transparent,
            child: ConditionsBoxes(context: context, character: character, characterFormNotifier: characterFormNotifier)
          ),
          RatingBoxes(context: context, character: character, characterFormNotifier: characterFormNotifier),
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

  Future saveCharacter(Character character) async{
    if (formKey.currentState!.validate()) {
      final repository = await CharacterRepository.getInstance();

      character = await repository.updateCharacter(character);
    }
  }

}








