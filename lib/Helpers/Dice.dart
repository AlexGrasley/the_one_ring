import 'dart:math';
import 'package:flutter/material.dart';

import '../Models/Armour.dart';
import '../Models/Character.dart';
import '../Models/D6Results.dart';
import '../Models/DiceResult.dart';
import '../Models/Skills.dart';
import '../Models/Weapon.dart';
import '../Widgets/DiamondShape.dart';
import '../Widgets/SKillDiceResultsDisplay.dart';
import 'Utilities.dart';
import 'package:the_one_ring/Models/TargetNumberWithTitle.dart';

class Dice {

  static DiceResult rollDice(int d6Count,int targetNumber, RollStatus rollStatus, {bool isMiserable = false})
  {
    int d12Result = _rollDTwelve(rollStatus);
    D6Results d6Result = _rollD6(d6Count);
    RollResults rollResults;

    //rolling a 12 is a Gandalf rune and an automatic success
    if(d12Result == 12 && d6Result.greatSuccessCount > 0)
    {
      rollResults = RollResults.greatSuccess;
    }
    else
    {
      //either a Gandalf run (12), or player exceeded target number.
      rollResults = d12Result == 12 || (d12Result + d6Result.total) > targetNumber ?
        RollResults.success :
        RollResults.failed;
    }

    //if player is miserable, then
    if(isMiserable)
    {
      rollResults = d12Result == 0 ? rollResults = RollResults.failed : rollResults;
    }

    return DiceResult(
        d12: d12Result,
        d6: d6Result.total,
        greatSuccessCount: d6Result.greatSuccessCount,
        rollStatus: rollStatus,
        rollResults: rollResults
    );
  }

  static int _rollDTwelve(RollStatus rollStatus)
  {
    var rng = Random();
    int result = 0;
    int d12One = rng.nextInt(12) + 1;
    int d12Two = rng.nextInt(12) + 1;

    //11's count as a Sauron rune, which results in a 0 for the purposes of the dice role
    d12One = d12One == 11 ? 0 : d12One;
    d12Two = d12Two == 11 ? 0 : d12Two;

    switch(rollStatus)
    {
      case RollStatus.standard:
        result = d12One;
        break;
      case RollStatus.favored:
        result = max(d12One, d12Two);
        break;
      case RollStatus.illFavored:
        result = min(d12One, d12Two);
        break;
    }

    return result;
  }

  static D6Results _rollD6(int diceCount)
  {
    var rng = Random();
    int greatSuccessCount = 0;
    int d6Total = 0;

    for(var i = 0; i < diceCount; i++)
    {
      var result = rng.nextInt(6) + 1;
      if (result == 6){
        greatSuccessCount++;
      }
      d6Total += result;
    }

    return D6Results(total: d6Total, greatSuccessCount: greatSuccessCount);
  }

  static DiceResult getDiceResultsSkill(Skill skill, Character character)
  {
    var rollStatus = RollStatus.standard;

    if(character.shadow + character.shadowScars == character.currentHope)
    {
      rollStatus = RollStatus.illFavored;
    }
    else if(skill.isFavored)
    {
      rollStatus = RollStatus.favored;
    }

    var results = Dice.rollDice(
        skill.pips,
        Utilities.getSkillTargetNumber(character, skill).targetNumber,
        rollStatus,
        isMiserable: character.miserable);

    return results;
  }

  static DiceResult getDiceResultsWeapon(Weapon weapon, Character character)
  {
    var rollStatus = RollStatus.standard;

    if(character.shadow + character.shadowScars == character.currentHope)
    {
      rollStatus = RollStatus.illFavored;
    }

    var weaponProficiencyType =
      Utilities.enumFromString(WeaponProficiencyType.values, weapon.proficiencyType);

    var characterWeaponProficiency = character.combatProficiencies
        .firstWhere((element) => element.name == weaponProficiencyType.name);

    var results = Dice.rollDice(
        characterWeaponProficiency.proficiency,
        character.strengthTn,
        rollStatus,
        isMiserable: character.miserable);

    return results;
  }

  static DiceResult getDiceResultsArmour(Armour armour, Character character)
  {
    //TODO Implement
    return DiceResult(d12: 0, d6: 0, greatSuccessCount: 0, rollStatus: RollStatus.standard, rollResults: RollResults.failed);
  }

  static String getRollStatusString(DiceResult results, Character character)
  {
    String rollStatus = results.rollStatus.description;

    rollStatus += character.miserable ? " ${rollStatus.isEmpty ? "" : "-"} Miserable" : "";
    return rollStatus;
  }

}

enum RollStatus
{
  standard(description: ""),
  favored(description: "Favored"),
  illFavored(description: "Ill Favored");

  const RollStatus({
    required this.description
  });

  final String description;
}

enum RollResults
{
  failed(description: "Failed"),
  success(description: "Success"),
  greatSuccess(description: "Great Success!");

  const RollResults({
    required this.description
  });

  final String description;
}
