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

import '../Helpers/Dialogs.dart';
import '../Helpers/Dice.dart';
import '../Models/Weapon.dart';
import '../StateNotifiers/ArmourStateNotifier.dart';
import '../StateNotifiers/WeaponStateNotifier.dart';
import '../Widgets/AddItemDialog.dart';
import '../Widgets/ArmourCard.dart';
import '../Widgets/ArmourCarousel.dart';
import '../Widgets/CombatProficiencyRow.dart';
import '../Widgets/WeaponCarousel.dart';

// Create a provider for SkillsRepository.
final combatProfRepositoryProvider = Provider((ref) => CombatProficienciesRepository.getInstance());

final armourRepositoryProvider = Provider((ref) => ArmourRepository.getInstance());

final weaponRepositoryProvider = Provider((ref) => WeaponRepository.getInstance());

final combatProfStateNotifierProviderFamily = FutureProvider.family<CombatProfStateNotifier, int>((ref, characterId) async
{
  final characterRepository = await ref.watch(characterRepositoryProvider);
  final combatProfs = characterRepository.getCharacterCombatProfs(characterId);

  return CombatProfStateNotifier(combatProfs ?? []);
});

final weaponsStateNotifierProviderFamily = FutureProvider.family<WeaponStateNotifier, int>((ref, characterId) async
{
  final characterRepository = await ref.watch(characterRepositoryProvider);
  final weapons = characterRepository.getCharacterWeapons(characterId);

  return WeaponStateNotifier(weapons ?? []);
});

final armourStateNotifierProviderFamily = FutureProvider.family<ArmourStateNotifier, int>((ref, characterId) async
{
  final characterRepository = await ref.watch(characterRepositoryProvider);
  final armour = characterRepository.getCharacterArmour(characterId);

  return ArmourStateNotifier(armour ?? []);
});

final combatProfsStateNotifierProvider = StateNotifierProvider.autoDispose.family<CombatProfStateNotifier, List<CombatProficiencies>, Character>((ref, character)
{
  return CombatProfStateNotifier(character.combatProficiencies);
});

final weaponsStateNotifierProvider = StateNotifierProvider.autoDispose.family<WeaponStateNotifier, List<Weapon>, Character>((ref, character)
{
  return WeaponStateNotifier(character.weapons);
});

final armourStateNotifierProvider = StateNotifierProvider.autoDispose.family<ArmourStateNotifier, List<Armour>, Character>((ref, character)
{
  return ArmourStateNotifier(character.armour);
});

class CombatDataForm extends ConsumerStatefulWidget
{

  const CombatDataForm(this._character, {super.key});

  final Character _character;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CombatDataFormState();
}


class _CombatDataFormState extends ConsumerState<CombatDataForm>
{
  late Future<List<Skill>?> skills;
  SkillClass? currentSkillClass;

  @override
  Widget build(BuildContext context)
  {

    final combatProfs = ref.watch(combatProfsStateNotifierProvider(widget._character));
    final combatProfFormProvider = ref.read(combatProfsStateNotifierProvider(widget._character).notifier);

    final character = ref.watch(characterStateProvider(widget._character));
    final characterFormNotifier = ref.watch(characterStateProvider(widget._character).notifier);

    final weapons = character.weapons;
    final weaponsFormProvider = ref.read(weaponsStateNotifierProvider(widget._character).notifier);

    final armour = character.armour;
    final armourFormProvider = ref.read(armourStateNotifierProvider(widget._character).notifier);

    void removeWeapon(Weapon w, Character c) async
    {
      c.weapons.remove(w);
      var repo = await ref.watch(characterRepositoryProvider);
      repo.updateCharacter(c);
      characterFormNotifier.updateWeapons(c.weapons);
    }

    void removeArmour(Armour a, Character c) async
    {
      c.armour.remove(a);
      var repo = await ref.watch(characterRepositoryProvider);
      repo.updateCharacter(c);
      characterFormNotifier.updateArmour(c.armour);
    }

    void rollWeaponDice(Weapon weapon, Character character)
    {
      var result = Dice.getDiceResultsWeapon(weapon, character);
      Dialogs.showDiceResultsWeaponDialog(context, result, character, weapon);
    }

    void rollArmourDice(Armour armour, Character character)
    {
      var result = Dice.getDiceResultsArmour(armour, character);
      Dialogs.showDiceResultsArmourDialog(context, result, character, armour);
    }

    return SingleChildScrollView(
        child: Column(
          children: [
            LabeledDivider(
              label: 'Combat Proficiency',
              afterTextWidget: Container()
            ),
            Column(
              children: combatProfs
                  .where((element) => element.name != WeaponProficiencyType.brawling.name)
                  .toList()
                  .asMap()
                  .entries.map<Widget>((entry)
              {

                int index = entry.key;
                CombatProficiencies combatProf = entry.value;

                return CombatProficiencyRow(
                    context: context,
                    ref: ref,
                    index: index,
                    combatProf: combatProf,
                    combatProfFormProvider: combatProfFormProvider
                );

              }).toList(),
            ),
            LabeledDivider(
                label: 'Weapons',
              afterTextWidget: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () =>  Dialogs.showAddWeaponDialog(
                        context,
                        ref,
                        widget._character,
                        weaponRepositoryProvider,
                        characterFormNotifier
                    ),
                    child: const Icon(FontAwesomeIcons.plus, color: Colors.blueGrey)
                ),
              ),
            ),
            WeaponCarousel(
              weapons: weapons,
              character: widget._character,
              showDice: true,
              rollDice: rollWeaponDice,
              removeWeapon: removeWeapon,
            ),
            LabeledDivider(
                label: 'Armour',
                afterTextWidget: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () =>  Dialogs.showAddArmourDialog(context, ref, widget._character, armourRepositoryProvider,characterFormNotifier),
                      child: const Icon(FontAwesomeIcons.plus, color: Colors.blueGrey)
                  ),
                ),
            ),
            ArmourCarousel(
              armour: armour,
              character: widget._character,
              showDice: true,
              rollDice: Dice.getDiceResultsArmour,
              removeArmour: removeArmour,
            ),
            ],
          )
        );
    }

}

