import 'package:flutter/material.dart';
import '../Helpers/DiamondShapePainter.dart';
import '../Models/Character.dart';
import 'DiamondShape.dart';

class WitsRatingBoxes extends StatelessWidget {
  final Character character;

  const WitsRatingBoxes(this.character, {super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DiamondShape(character.witsTn.toString(), "TN", labelPosition: LabelPosition.bottomLeft, size: 75),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                      child:
                      DiamondShape(character.witsRating.toString(), "Rating", labelPosition: LabelPosition.topRight, size: 50,drawSecondLine: false)
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child:
                      DiamondShape(character.parry.toString(), "Parry", labelPosition: LabelPosition.bottomRight, size: 50,drawSecondLine: false)
                  ),
                ],
              )

            ]
        ),
      ],
    );
  }
}