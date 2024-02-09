import 'package:flutter/material.dart';

import '../Helpers/Utilities.dart';
import '../Models/Character.dart';
import '../StateNotifiers/CharacterStateNotifier.dart';
import 'HeartRatingBoxes.dart';
import 'StrenghtRatingBoxes.dart';
import 'WitsRatingBoxes.dart';

class RatingBoxes extends StatelessWidget
{
  const RatingBoxes({
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
    return Column(
      children:
      [
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
                  "Update Strength",
                  "Strength Target Number",
                  character.strengthTn.toString(),
                  "Strength Rating",
                  character.strengthRating.toString(),
                  "Endurance",
                  character.endurance.toString(),
                  characterFormNotifier.updateStrengthTn,
                  characterFormNotifier.updateStrengthRating,
                  characterFormNotifier.updateEndurance
                ),
                child: Card(
                  shadowColor: Colors.blueGrey,
                  color: Colors.transparent,
                  child:
                  Column(
                    children:
                    [
                      const Text("strength", style: TextStyle(color: Colors.red, fontSize: 18),),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(3,3,25,3),
                        child: StrengthRatingBoxes(character),
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
                  "Update Heart",
                  "Heart Target Number",
                  character.heartTn.toString(),
                  "Heart Rating",
                  character.heartRating.toString(),
                  "Hope",
                  character.hope.toString(),
                  characterFormNotifier.updateHeartTn,
                  characterFormNotifier.updateHeartRating,
                  characterFormNotifier.updateHope
                ),
                child: Card(
                  shadowColor: Colors.blueGrey,
                  color: Colors.transparent,
                  child: Column(
                    children:
                    [
                      const Text("heart", style: TextStyle(color: Colors.red, fontSize: 18),),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(3,3,25,3),
                        child: HeartRatingBoxes(character),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        InkWell(
          onTap: () =>
          Utilities.showStatUpdateDialog(
            context,
            character,
            "Update Wits",
            "Wits Target Number",
            character.witsTn.toString(),
            "Wits Rating",
            character.witsRating.toString(),
            "Parry",
            character.parry.toString(),
            characterFormNotifier.updateWitsTn,
            characterFormNotifier.updateWitsRating,
            characterFormNotifier.updateParry
          ),
          child: SizedBox(
            width: 225,
            child: Card(
              shadowColor: Colors.blueGrey,
              color: Colors.transparent,
              child: Column(
                children:
                [
                  const Text("wits", style: TextStyle(color: Colors.red, fontSize: 18),),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(3,3,25,3),
                    child: WitsRatingBoxes(character),
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