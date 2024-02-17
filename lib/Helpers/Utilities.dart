
import 'package:flutter/material.dart';

import '../Models/Character.dart';
import '../Models/Skills.dart';
import '../Models/TargetNumberWithTitle.dart';
import '../Repositories/CharacterRepository.dart';
import '../Widgets/TextFormInput.dart';

class Utilities
{

  static T enumFromString<T>(Iterable<T> values, String value)
  {
    return values.firstWhere(
      (type) => type.toString().split(".").last == value,
      orElse: () => values.first
    );
  }

  static TargetNumberWithTitle getSkillTargetNumber(Character character, Skill skill)
  {
    var skillClass = Utilities.enumFromString(SkillClass.values, skill.skillClass);

    switch (skillClass)
    {
      case SkillClass.strength:
        return TargetNumberWithTitle(skillClass.description, character.strengthTn);
      case SkillClass.heart:
        return TargetNumberWithTitle(skillClass.description, character.heartTn);
      case SkillClass.wits:
        return TargetNumberWithTitle(skillClass.description, character.witsTn);
    }
  }

  static Future<void> saveCharacter(character) async
  {
    var repo = await CharacterRepository.getInstance();
    await repo.updateCharacter(character);
  }

  static Future<void> showStatUpdateDialog(
    BuildContext context,
    Character character,
    String title,
    String targetNumberLabel,
    String targetNumberInitValue,
    String ratingLabel,
    String ratingInitValue,
    String otherLabel,
    String otherInitValue,
    Function(int) updateTargetNumber,
    Function(int) updateRating,
    Function(int) updateOther) async
  {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context)
      {
        return AlertDialog(
          title: Text(title, style: const TextStyle(color: Colors.white)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                TextFormInput(
                  initialValue: targetNumberInitValue,
                  labelText: targetNumberLabel,
                  isNumberEntry: true,
                  onChanged: (value)
                  {
                    updateTargetNumber(int.parse(value));
                  }
                ),
                TextFormInput(
                  initialValue: ratingInitValue,
                  labelText: ratingLabel,
                  isNumberEntry: true,
                  onChanged: (value)
                  {
                    updateRating(int.parse(value));
                  }
                ),
                TextFormInput(
                  initialValue: otherInitValue,
                  labelText: otherLabel,
                  isNumberEntry: true,
                  onChanged: (value)
                  {
                    updateOther(int.parse(value));
                  }
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: ()
              {
                Navigator.of(context).pop();
              }
            )]);
      });
  }

}

