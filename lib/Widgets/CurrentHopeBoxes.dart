import 'package:flutter/material.dart';
import '../Helpers/DiamondShapePainter.dart';
import '../Models/Character.dart';
import 'DiamondShape.dart';

class CurrentHopeRatingBoxes extends StatelessWidget
{
  final Character character;

  const CurrentHopeRatingBoxes(this.character, {super.key});

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
            DiamondShape(character.currentHope.toString(), "", labelPosition: LabelPosition.bottomLeft, size: 75),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                  child: DiamondShape(character.shadow.toString(), "Shadow", labelPosition: LabelPosition.topRight, size: 50,drawSecondLine: false)
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,8,0,8),
                  child: DiamondShape(character.shadowScars.toString(), "Sh. Scars", labelPosition: LabelPosition.bottomRight, size: 50,drawSecondLine: false)
                ),
              ],
            )

          ]
        ),
      ],
    );
  }
}