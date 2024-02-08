import 'dart:math';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:objectbox/src/relations/to_many.dart';
import 'package:the_one_ring/Models/Armour.dart';
import 'package:the_one_ring/Models/Character.dart';
import 'package:the_one_ring/Models/CombatProficiencies.dart';
import 'package:the_one_ring/Models/Skills.dart';
import 'package:the_one_ring/Repositories/ArmourRepository.dart';
import 'package:the_one_ring/Repositories/CharacterRepository.dart';
import 'package:the_one_ring/Repositories/CombatProficienciesRepository.dart';
import 'package:the_one_ring/Repositories/WeaponRepository.dart';
import 'package:the_one_ring/StateNotifiers/CharacterStateNotifier.dart';
import 'package:the_one_ring/StateNotifiers/CombatProfStateNotifier.dart';
import 'package:the_one_ring/Widgets/LabeledDivider.dart';
import 'package:the_one_ring/Widgets/WeaponCard.dart';

import '../Models/Weapon.dart';
import '../StateNotifiers/ArmourStateNotifier.dart';
import '../StateNotifiers/WeaponStateNotifier.dart';
import '../Widgets/ArmourCard.dart';
import '../Widgets/ArmourCarousel.dart';
import '../Widgets/CombatProficiencyRow.dart';
import '../Widgets/WeaponCarousel.dart';

// Create a provider for SkillsRepository.
final combatProfRepositoryProvider = Provider((ref) => CombatProficienciesRepository.getInstance());
// Create a provider for CharacterRepository.
final characterRepositoryProvider = Provider((ref) => CharacterRepository.getInstance());

final armourRepositoryProvider = Provider((ref) => ArmourRepository.getInstance());

final weaponRepositoryProvider = Provider((ref) => WeaponRepository.getInstance());

final combatProfStateNotifierProviderFamily = FutureProvider.family<CombatProfStateNotifier, int>((ref, characterId) async {
  final characterRepository = await ref.watch(characterRepositoryProvider);
  final combatProfs = characterRepository.getCharacterCombatProfs(characterId);

  return CombatProfStateNotifier(combatProfs ?? []);
});

final weaponsStateNotifierProviderFamily = FutureProvider.family<WeaponStateNotifier, int>((ref, characterId) async {
  final characterRepository = await ref.watch(characterRepositoryProvider);
  final weapons = characterRepository.getCharacterWeapons(characterId);

  return WeaponStateNotifier(weapons ?? []);
});

final armourStateNotifierProviderFamily = FutureProvider.family<ArmourStateNotifier, int>((ref, characterId) async {
  final characterRepository = await ref.watch(characterRepositoryProvider);
  final armour = characterRepository.getCharacterArmour(characterId);

  return ArmourStateNotifier(armour ?? []);
});

final combatProfsStateNotifierProvider = StateNotifierProvider.autoDispose.family<CombatProfStateNotifier, List<CombatProficiencies>, Character>((ref, character) {
  return CombatProfStateNotifier(character.combatProficiencies);
});

final weaponsStateNotifierProvider = StateNotifierProvider.autoDispose.family<WeaponStateNotifier, List<Weapon>, Character>((ref, character) {
  return WeaponStateNotifier(character.weapons);
});

final armourStateNotifierProvider = StateNotifierProvider.autoDispose.family<ArmourStateNotifier, List<Armour>, Character>((ref, character) {
  return ArmourStateNotifier(character.armour);
});

class CombatDataForm extends ConsumerStatefulWidget {

  const CombatDataForm(this._character, {super.key});

  final Character _character;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CombatDataFormState();
}


class _CombatDataFormState extends ConsumerState<CombatDataForm> {
  late Future<List<Skill>?> skills;
  SkillClass? currentSkillClass;

  @override
  Widget build(BuildContext context) {

    final combatProfs = ref.watch(combatProfsStateNotifierProvider(widget._character));
    final combatProfFormProvider = ref.read(combatProfsStateNotifierProvider(widget._character).notifier);

    final character = ref.watch(characterStateProvider(widget._character));
    final characterFormNotifier = ref.watch(characterStateProvider(widget._character).notifier);

    final weapons = character.weapons;
    final weaponsFormProvider = ref.read(weaponsStateNotifierProvider(widget._character).notifier);

    final armour = character.armour;
    final armourFormProvider = ref.read(armourStateNotifierProvider(widget._character).notifier);

    return SingleChildScrollView(
        child: Column(
          children: [
            LabeledDivider(
              label: "Combat Proficiency",
              afterTextWidget: Container()
            ),
            Column(
              children: combatProfs.asMap().entries.map<Widget>((entry) {

                int index = entry.key;
                CombatProficiencies combatProf = entry.value;

                return CombatProficiencyRow(context: context, ref: ref, index: index, combatProf: combatProf, combatProfFormProvider: combatProfFormProvider);

              }).toList(),
            ),
            LabeledDivider(
                label: "Weapons",
              afterTextWidget: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () =>  _showAddWeaponAlert(context, ref, widget._character, weaponRepositoryProvider,characterFormNotifier),
                    child: const Icon(FontAwesomeIcons.plus, color: Colors.blueGrey)
                ),
              ),
            ),
            WeaponCarousel(weapons: weapons),
            LabeledDivider(
                label: "Armour",
                afterTextWidget: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () =>  _showAddArmourAlert(context, ref, widget._character, armourRepositoryProvider,characterFormNotifier),
                      child: const Icon(FontAwesomeIcons.plus, color: Colors.blueGrey)
                  ),
                ),
            ),
            ArmourCarousel(armour: armour),
            ],
          )
        );
    }

  Future<void> _showAddWeaponAlert(
      BuildContext context,
      WidgetRef ref,
      Character character,
      Provider<Future<WeaponRepository>> weaponRepositoryProvider,
      CharacterStateNotifier characterStateNotifier) async
  {

    var repo = await ref.watch(weaponRepositoryProvider);
    List<Weapon> masterWeaponsList = repo.getMasterWeaponsList();

    if(context.mounted) {
      Weapon? selectedWeapon;

      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(  // adding StatefulBuilder
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                title: const Text('Add a weapon', style: TextStyle(color: Colors.blueGrey)),
                content: DropdownButton<Weapon>(
                  hint: const Text('Select a weapon', style: TextStyle(color: Colors.blueGrey)),
                  value: selectedWeapon,
                  onChanged: (Weapon? value) {
                    setState(() {  // It will now work
                      selectedWeapon = value;
                    });
                  },
                  items: masterWeaponsList.map((Weapon weapon) {
                    return DropdownMenuItem<Weapon>(
                      value: weapon,
                      child: Text(weapon.name, style: const TextStyle(color: Colors.blueGrey)),
                    );
                  }).toList(),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancel', style: TextStyle(color: Colors.blueGrey)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('OK', style: TextStyle(color: Colors.red)),
                    onPressed: () async {
                      if (selectedWeapon != null) {
                        character.weapons.add(selectedWeapon!);
                        var repo = await ref.watch(characterRepositoryProvider);
                        repo.updateCharacter(character);
                        characterStateNotifier.updateWeapons(character.weapons);
                      }
                      if(context.mounted){
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              );
            },
          );
        },
      );
    }
  }

  Future<void> _showAddArmourAlert(
      BuildContext context,
      WidgetRef ref,
      Character character,
      Provider<Future<ArmourRepository>> armourRepositoryProvider,
      CharacterStateNotifier characterStateNotifier) async
  {

    var repo = await ref.watch(armourRepositoryProvider);
    List<Armour> masterArmourList = repo.getMasterArmourList();

    if(context.mounted) {
      Armour? selectedArmour;

      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(  // adding StatefulBuilder
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                title: const Text('Add armour', style: TextStyle(color: Colors.blueGrey)),
                content: DropdownButton<Armour>(
                  hint: const Text('Select armour', style: TextStyle(color: Colors.blueGrey)),
                  value: selectedArmour,
                  onChanged: (Armour? value) {
                    setState(() {  // It will now work
                      selectedArmour = value;
                    });
                  },
                  items: masterArmourList.map((Armour armour) {
                    return DropdownMenuItem<Armour>(
                      value: armour,
                      child: Text(armour.name, style: const TextStyle(color: Colors.blueGrey)),
                    );
                  }).toList(),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancel', style: TextStyle(color: Colors.blueGrey)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: const Text('OK', style: TextStyle(color: Colors.red)),
                    onPressed: () async {
                      if (selectedArmour != null) {
                        character.armour.add(selectedArmour!);
                        var repo = await ref.watch(characterRepositoryProvider);
                        repo.updateCharacter(character);
                        characterStateNotifier.updateArmour(character.armour);
                      }
                      if(context.mounted){
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              );
            },
          );
        },
      );
    }
  }

}



void showDiceResults(BuildContext context, Map<String, int> results, Character character, CombatProficiencies combatProf) {

  var total = results.values.reduce((value1, value2) => value1 + value2);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.55), // Or any other value according to preference
            child: AlertDialog(
              title: const Center(child: Text('Results')),
              content:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: results.entries.map((e) => Text('${e.key}: ${e.value}')).toList(),
                  ),
                  const SizedBox(height: 10),
                  Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Text(total.toString(), style: const TextStyle(fontSize: 26, color: Colors.white))
                  )
                ],
              ),
              actions: [
                ElevatedButton(
                  child: const Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          )
      );
    },
  );
}