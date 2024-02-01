import 'package:flutter/material.dart';
import '../Models/Character.dart';
import 'DiamondShape.dart';

class HeartRatingBoxes extends StatelessWidget {
  final Character character;

  const HeartRatingBoxes(this.character, {super.key});

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DiamondShape(character.heartTn.toString(), "TN", isLabelTopRight: false, size: 75),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                      child:
                      DiamondShape(character.heartRating.toString(), "Rating", isLabelTopRight: true, size: 50,drawSecondLine: false)
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(0,8,0,0),
                      child:
                      DiamondShape(character.hope.toString(), "Hope", isLabelTopRight: true, size: 50,drawSecondLine: false)
                  ),
                ],
              )
            ]
        ),
      ],
    );
  }
}