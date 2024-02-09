import 'package:flutter/material.dart';
import 'package:the_one_ring/Helpers/Utilities.dart';

import '../Models/Character.dart';
import '../StateNotifiers/CharacterStateNotifier.dart';
import 'CurrentEnduranceBoxes.dart';
import 'CurrentHopeBoxes.dart';

class StatBoxes extends StatelessWidget
{
  const StatBoxes({
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
    Row(
      children:
      [
        Expanded(
          child:
          InkWell(
            onTap: () =>
            Utilities.showStatUpdateDialog(
              context,
              character,
              "Update Endurance Stats",
              "Current Endurance",
              character.currentEndurance.toString(),
              "Load",
              character.load.toString(),
              "Fatigue",
              character.fatigue.toString(),
              characterFormNotifier.updateCurrentEndurance,
              characterFormNotifier.updateLoad,
              characterFormNotifier.updateFatigue
            ),
            child: Card(
              shadowColor: Colors.blueGrey,
              color: Colors.transparent,
              child:
              Column(
                children:
                [
                  const Text("Endurance", style: TextStyle(color: Colors.red, fontSize: 18),),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(3,3,25,3),
                    child: CurrentEnduranceRatingBoxes(character),
                  ),
                ],
              )
            ),
          ),
        ),
        Expanded(
          child:
          InkWell(
            onTap: () =>
            Utilities.showStatUpdateDialog(
              context,
              character,
              "Update Hope States",
              "Current Hope",
              character.currentHope.toString(),
              "Shadow",
              character.shadow.toString(),
              "Shadow Scars",
              character.shadowScars.toString(),
              characterFormNotifier.updateCurrentHope,
              characterFormNotifier.updateShadow,
              characterFormNotifier.updateShadowScars
            ),
            child: Card(
              shadowColor: Colors.blueGrey,
              color: Colors.transparent,
              child: Column(
                children:
                [
                  const Text("Heart", style: TextStyle(color: Colors.red, fontSize: 18),),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(3,3,25,3),
                    child: CurrentHopeRatingBoxes(character),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}