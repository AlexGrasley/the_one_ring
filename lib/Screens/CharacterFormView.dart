import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:the_one_ring/Repositories/CharacterRepository.dart';
import '../Models/Character.dart';
import '../StateNotifiers/CharacterStateNotifier.dart';
import 'CombatDataForm.dart';
import '../Widgets/MenuDrawer.dart';
import 'UpdateCharacterForm.dart';
import 'ViewSkillsForm.dart';

class CharacterView extends ConsumerStatefulWidget
{
  final Character _character;
  const CharacterView(this._character, {super.key});

  @override
  _CharacterViewState createState() => _CharacterViewState();
}

class _CharacterViewState extends ConsumerState<CharacterView> with SingleTickerProviderStateMixin, WidgetsBindingObserver
{
  late final TabController _tabController;
  final _formKey = GlobalKey<FormState>();
  late String _title = widget._character.name;
  CharacterRepository? characterRepository;
  Character? character;

  @override
  void initState()
  {
    getRepo();
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabIndex);
    WidgetsBinding.instance.addObserver(this);
  }

  Future<void> getRepo() async
  {
    characterRepository = await CharacterRepository.getInstance();
  }

  @override
  void dispose()
  {
    WidgetsBinding.instance.removeObserver(this);
    _tabController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state)
  {
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
        if(character != null)
        {
          characterRepository?.updateCharacter(character!);
        }
        break;
      default:
        break;
    }
  }

  void _handleTabIndex()
  {
    setState(()
      {
        switch (_tabController.index)
        {
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

        if(character != null)
        {
          characterRepository?.updateCharacter(character!);
        }
      });
  }

  @override
  Widget build(BuildContext context)
  {
    final characterFormNotifier = ref.watch(characterStateProvider(widget._character).notifier);
    character = ref.watch(characterStateProvider(widget._character));

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.blueGrey,
          backgroundColor: Theme.of(context).primaryColorDark,
          title: Text(_title, style: const TextStyle(color: Colors.white)),
        ),
        body: TabBarView(
          controller: _tabController,
          children:
          [
            UpdateCharacterForm(
              formKey: _formKey,
              characterFormNotifier: characterFormNotifier,
              character: character!,),
            ViewSkillsForm(character!),
            CombatDataForm(
              character!,
              key: ValueKey(character!.weapons.length + character!.armour.length)
            ),
          ],
        ),
        drawer: MenuDrawer(
          character: character,
          deleteCharacter: (c) {
            if(character != null)
            {
              characterRepository?.removeCharacter(character?.id ?? 0);
            }
          },
        ),
        onDrawerChanged: (isOpen)
        {
          characterRepository?.updateCharacter(character!);
        },
        bottomNavigationBar: Material( //This is optional - you can remove this if not required
          color: Theme.of(context).primaryColorDark, // You can set the color according to your requirement
          child: TabBar(
            controller: _tabController,
            tabs: const
            [
              Tab(icon: Icon(FontAwesomeIcons.wpforms, color: Colors.red)),
              Tab(icon: Icon(FontAwesomeIcons.diceD20, color: Colors.red)),
              Tab(icon: Icon(FontAwesomeIcons.shield, color: Colors.red))
            ],
          ),
        ),
      ),
    );
  }
}