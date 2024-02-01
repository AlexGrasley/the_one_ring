import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_one_ring/Repositories/CharacterRepository.dart';
import '../Models/Character.dart';
import '../StateNotifiers/CharacterStateNotifier.dart';
import '../Widgets/CombatData.dart';
import '../Widgets/TextFormInput.dart';
import '../Widgets/UpdateCharacterForm.dart';
import '../Widgets/ViewCharacterForm.dart';
import '../Widgets/ViewSkillsForm.dart';


final characterFormProvider = StateNotifierProvider.autoDispose.family<CharacterFormNotifier, Character, Character>((ref, character) {
  return CharacterFormNotifier(character);
});

class ReadOnlyNotifier extends StateNotifier<bool> {
  ReadOnlyNotifier(bool isReadOnly) : super(isReadOnly);

  void toggle() {
    state = !state;
  }
}

final readOnlyProvider = StateNotifierProvider.autoDispose.family<ReadOnlyNotifier,bool, bool>((ref, isReadOnly) {
  return ReadOnlyNotifier(isReadOnly);
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
    final readOnlyNotifier = ref.read(readOnlyProvider(this.isReadOnly).notifier);
    final isReadOnly = ref.watch(readOnlyProvider(this.isReadOnly)); // watching for changes to isReadOnly

    return DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.view_array_outlined)),
                Tab(icon: Icon(FontAwesomeIcons.diceD20)),
                Tab(icon: Icon(FontAwesomeIcons.shield)),
                Tab(icon: Icon(Icons.note_alt_outlined))
              ],
            ),
            title: Text(character.name),
          ),
          body: TabBarView(
            children: [
              UpdateCharacterForm(
                  formKey: _formKey,
                  characterFormNotifier: characterFormNotifier,
                  character: character),
              ViewSkillsForm(character),
              CombatDataForm(character),
              UpdateCharacterForm(
                  formKey: _formKey,
                  characterFormNotifier: characterFormNotifier,
                  character: character),
            ],
          ),
        ),
      );
  }

}