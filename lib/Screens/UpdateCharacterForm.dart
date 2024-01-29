import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:the_one_ring/Repositories/CharacterRepository.dart';
import '../Models/Character.dart';
import '../StateNotifiers/CharacterStateNotifier.dart';
import '../Widgets/TextFormInput.dart';

final characterFormProvider = StateNotifierProvider<CharacterFormNotifier, Character>((ref) {
  return CharacterFormNotifier();
});

class UpdateCharacterForm extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();

  UpdateCharacterForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(children: [
          TextFormInput(
            labelText: 'Name',
            onChanged: (value) {
              ref.read(characterFormProvider.notifier).updateName(value);
            },
          ),
          TextFormInput(
              labelText: 'Heroic Culture',
            onChanged: (value) {
              ref.read(characterFormProvider.notifier).updateHeroicCulture(value);
            },
          ),
          TextFormInput(
              labelText: 'Cultural Blessing',
            onChanged: (value) {
              ref.read(characterFormProvider.notifier).updateCulturalBlessing(value);
            },
          ),
          TextFormInput(
            labelText: 'Patron',
            onChanged: (value) {
              ref.read(characterFormProvider.notifier).updatePatron(value);
            },
          ),
          TextFormInput(
            labelText: 'Calling',
            onChanged: (value) {
              ref.read(characterFormProvider.notifier).updateCalling(value);
            },
          ),
          TextFormInput(
            labelText: 'Shadow Path',
            onChanged: (value) {
              ref.read(characterFormProvider.notifier).updateShadowPath(value);
            },
          ),
          ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final character = ref.read(characterFormProvider);
                final repository = CharacterRepository();
                repository.addCharacter(character);
                print('Character saved');
              }
            },
            child: const Text('Save Character'),
          ),
        ]),
      ),
    );
  }
}