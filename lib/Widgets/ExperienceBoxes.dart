import 'package:flutter/material.dart';

import '../Helpers/Utilities.dart';
import '../Models/Character.dart';
import '../StateNotifiers/CharacterStateNotifier.dart';
import 'DiamondShape.dart';

class ExperienceBoxes extends StatelessWidget
{
  const ExperienceBoxes({
    super.key,
    required this.context,
    required this.character,
    required this.characterFormNotifier,
  });

  final BuildContext context;
  final Character character;
  final CharacterStateNotifier characterFormNotifier;

  @override
  Widget build(BuildContext context)
  {
    return
    InkWell(
      onTap: () => Utilities.showStatUpdateDialog(
        context,
        character,
        "Update Experience",
        "Adventure Points",
        character.adventurePoint.toString(),
        "Skill Points",
        character.skillPoints.toString(),
        "Fellowship Score",
        character.fellowshipScore.toString(),
        characterFormNotifier.updateAdventurePoint,
        characterFormNotifier.updateSkillPoints,
        characterFormNotifier.updateFellowshipScore
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
        [
          Expanded(
            child: Column(
              children:
              [
                const Text("Adventure", style: TextStyle(fontSize: 18, color: Colors.red)),
                const Text("Points", style: TextStyle(fontSize: 18, color: Colors.red)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child:
                  DiamondShape(character.adventurePoint.toString(), "", size: 50,drawSecondLine: false)
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children:
              [
                const Text("Skill", style: TextStyle(fontSize: 18, color: Colors.red)),
                const Text("Points", style: TextStyle(fontSize: 18, color: Colors.red)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child:
                  DiamondShape(character.skillPoints.toString(), "", size: 50,drawSecondLine: false)
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children:
              [
                const Text("Fellowship", style: TextStyle(fontSize: 18, color: Colors.red)),
                const Text("Score", style: TextStyle(fontSize: 18, color: Colors.red)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child:
                  DiamondShape(character.fellowshipScore.toString(), "", size: 50,drawSecondLine: false)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}