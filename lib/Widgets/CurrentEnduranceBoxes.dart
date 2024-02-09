import 'package:flutter/material.dart';
import '../Helpers/DiamondShapePainter.dart';
import '../Models/Character.dart';
import 'DiamondShape.dart';

class CurrentEnduranceRatingBoxes extends StatelessWidget
{
  final Character character;

  const CurrentEnduranceRatingBoxes(this.character, {super.key});

  @override
  Widget build(BuildContext context)
  {

    return Column(
      children:
      [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            DiamondShape(character.currentEndurance.toString(), "", labelPosition: LabelPosition.bottomLeft, size: 75),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: DiamondShape(character.load.toString(), "Load", labelPosition: LabelPosition.topRight, size: 50,drawSecondLine: false)
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,8,0,8),
                  child: DiamondShape(character.fatigue.toString(), "Fatigue", labelPosition: LabelPosition.bottomRight, size: 50,drawSecondLine: false)
                ),
              ],
            )

          ]
        ),
      ],
    );
  }
}