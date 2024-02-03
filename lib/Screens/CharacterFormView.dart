import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Models/Character.dart';
import '../StateNotifiers/CharacterStateNotifier.dart';
import '../Widgets/CombatDataForm.dart';
import '../Widgets/UpdateCharacterForm.dart';
import '../Widgets/ViewSkillsForm.dart';


final characterFormProvider = StateNotifierProvider.autoDispose.family<CharacterFormNotifier, Character, Character>((ref, character) {
  return CharacterFormNotifier(character);
});

class CharacterView extends ConsumerStatefulWidget {
  final Character _character;
  const CharacterView(this._character, {super.key});

  @override
  _CharacterViewState createState() => _CharacterViewState();
}

class _CharacterViewState extends ConsumerState<CharacterView> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final _formKey = GlobalKey<FormState>();
  late String _title = widget._character.name;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabIndex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    setState(() {
      switch (_tabController.index) {
        case 0:
          _title = widget._character.name;
          break;
        case 1:
          _title = 'Skills';
          break;
        case 2:
          _title = 'Combat Proficiencies';
          break;
        default:
          _title = widget._character.name;
          break;
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    final characterFormNotifier = ref.watch(characterFormProvider(widget._character).notifier);
    final character = ref.watch(characterFormProvider(widget._character));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text(_title, style: const TextStyle(color: Colors.white),),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          UpdateCharacterForm(
              formKey: _formKey,
              characterFormNotifier: characterFormNotifier,
              character: character),
          ViewSkillsForm(character),
          CombatDataForm(
            character,
            key: ValueKey(character.weapons.length + character.armour.length)
          ),
        ],
      ),
      bottomNavigationBar: Material( //This is optional - you can remove this if not required
        color: Theme.of(context).primaryColorDark, // You can set the color according to your requirement
        child: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.view_array_outlined, color: Colors.red)),
            Tab(icon: Icon(FontAwesomeIcons.diceD20, color: Colors.red)),
            Tab(icon: Icon(FontAwesomeIcons.shield, color: Colors.red))
          ],
        ),
      ),
    );
  }
}