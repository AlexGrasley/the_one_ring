import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Models/Armour.dart';
import '../Models/Character.dart';
import '../Models/DiceResult.dart';
import '../Models/Skills.dart';
import '../Models/Weapon.dart';
import '../Repositories/ArmourRepository.dart';
import '../Repositories/CharacterRepository.dart';
import '../Repositories/WeaponRepository.dart';
import '../StateNotifiers/CharacterStateNotifier.dart';
import '../Widgets/AddItemDialog.dart';
import '../Widgets/ArmourCarousel.dart';
import '../Widgets/DialogCloseButton.dart';
import '../Widgets/SKillDiceResultsDisplay.dart';
import '../Widgets/WeaponCarousel.dart';
import 'Dice.dart';
import 'Utilities.dart';

class Dialogs {

  static Future<void> showAddWeaponDialog(
      BuildContext context,
      WidgetRef ref,
      Character character,
      Provider<Future<WeaponRepository>> weaponRepositoryProvider,
      CharacterStateNotifier characterStateNotifier) async
  {
    var repo = await ref.watch(weaponRepositoryProvider);
    List<Weapon> masterWeaponsList = repo.getMasterWeaponsList();

    void saveWeapon(Weapon weapon, Character character) async {
      character.weapons.add(weapon);
      var repo = await ref.watch(characterRepositoryProvider);
      repo.updateCharacter(character);
      characterStateNotifier.updateWeapons(character.weapons);
    }

    if(context.mounted) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(  // adding StatefulBuilder
            builder: (BuildContext context, StateSetter setState) {
              return AddItemDialog(
                title: "Add a weapon",
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    WeaponCarousel(
                        weapons: masterWeaponsList,
                        character: character,
                        showDice: false,
                        addWeapon: saveWeapon
                    ),
                    const DialogCloseButton()
                  ],
                ),
              );
            },
          );
        },
      );
    }
  }

  static Future<void> showAddArmourDialog(
      BuildContext context,
      WidgetRef ref,
      Character character,
      Provider<Future<ArmourRepository>> armourRepositoryProvider,
      CharacterStateNotifier characterStateNotifier) async
  {
    var repo = await ref.watch(armourRepositoryProvider);
    List<Armour> masterArmourList = repo.getMasterArmourList();

    void saveArmour(Armour armour, Character character) async {
      character.armour.add(armour);
      var repo = await ref.watch(characterRepositoryProvider);
      repo.updateCharacter(character);
      characterStateNotifier.updateArmour(character.armour);
    }

    if(context.mounted) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(  // adding StatefulBuilder
            builder: (BuildContext context, StateSetter setState) {
              return AddItemDialog(
                  title: "Add Armour",
                  content: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ArmourCarousel(
                          armour: masterArmourList,
                          character: character,
                          showDice: false,
                          addArmour: saveArmour
                      ),
                      const DialogCloseButton()
                    ],
                  )
              );
            },
          );
        },
      );
    }
  }

  static void showDiceResultsSKillDialog(BuildContext context, DiceResult results, Character character, Skill skill) {

    var targetNumber = Utilities.getSkillTargetNumber(character, skill);
    bool passed = results.rollResults == RollResults.success || results.rollResults == RollResults.greatSuccess;
    String rollStatus = Dice.getRollStatusString(results, character);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SkillDiceResultsDisplay(
            rollStatus: rollStatus,
            targetNumber: targetNumber,
            results: results,
            passed: passed);
      },
    );
  }


}
