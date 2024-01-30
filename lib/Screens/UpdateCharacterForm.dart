import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:the_one_ring/Repositories/CharacterRepository.dart';
import '../Models/Character.dart';
import '../StateNotifiers/CharacterStateNotifier.dart';
import '../Widgets/TextFormInput.dart';


final characterFormProvider = StateNotifierProvider.autoDispose.family<CharacterFormNotifier, Character, Character>((ref, character) {
  return CharacterFormNotifier(character);
});

class UpdateCharacterForm extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  late final Character _character;
  bool isNewCharacter = false;

  UpdateCharacterForm(this._character, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final characterFormNotifier = ref.read(characterFormProvider(_character).notifier);
    final character = ref.watch(characterFormProvider(_character));

    return Scaffold(
      appBar: AppBar(
        title: const Text("The One Ring"),
      ),
      body: Form(
        key: _formKey,
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
      ),
    );
  }

  Future saveCharacter(Character character) async{
    if (_formKey.currentState!.validate()) {
      final repository = await CharacterRepository.getInstance();

      if (isNewCharacter){
        repository.addCharacter(character);
      }
      else {
        repository.updateCharacter(character);
      }

    }
  }

}