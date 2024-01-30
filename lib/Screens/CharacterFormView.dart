import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:the_one_ring/Repositories/CharacterRepository.dart';
import '../Models/Character.dart';
import '../StateNotifiers/CharacterStateNotifier.dart';
import '../Widgets/TextFormInput.dart';
import '../Widgets/UpdateCharacterForm.dart';
import '../Widgets/ViewCharacterForm.dart';
import '../Widgets/ViewSkillsForm.dart';


final characterFormProvider = StateNotifierProvider.autoDispose.family<CharacterFormNotifier, Character, Character>((ref, character) {
  return CharacterFormNotifier(character);
});

class ReadOnlyNotifier extends StateNotifier<bool> {
  ReadOnlyNotifier() : super(true);

  void toggle() {
    state = !state;
  }
}

final readOnlyProvider = StateNotifierProvider<ReadOnlyNotifier, bool>((ref) {
  return ReadOnlyNotifier();
});

class CharacterView extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  late final Character _character;
  bool isReadOnly;

  CharacterView(this._character, {super.key, this.isReadOnly = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final characterFormNotifier = ref.read(characterFormProvider(_character).notifier);
    final character = ref.watch(characterFormProvider(_character));
    final isReadOnly = ref.watch(readOnlyProvider); // watching for changes to isReadOnly

    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.account_circle)),
                Tab(icon: Icon(Icons.shield)),
                Tab(icon: Icon(Icons.note_alt_outlined))
              ],
            ),
            title: Text(character.name),
          ),
          body: TabBarView(
            children: [
              isReadOnly?
              ViewCharacteForm(character: character,) :
              UpdateCharacterForm(
                  formKey: _formKey,
                  characterFormNotifier: characterFormNotifier,
                  character: character),
              ViewSkillForm(
                  character: character),
              UpdateCharacterForm(
                  formKey: _formKey,
                  characterFormNotifier: characterFormNotifier,
                  character: character),
              UpdateCharacterForm(
                  formKey: _formKey,
                  characterFormNotifier: characterFormNotifier,
                  character: character),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.edit),
            onPressed: () => {
              ref.read(readOnlyProvider.notifier).toggle()
            }
          ),
        ),
      );
  }

}