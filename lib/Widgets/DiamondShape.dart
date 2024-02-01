import 'package:flutter/material.dart';
import '../Helpers/DiamondShapePainter.dart';

class DiamondShape extends StatelessWidget {
  final String text;
  final String label;
  final bool isLabelTopRight;
  final double size;
  final bool drawSecondLine;

  const DiamondShape(this.text, this.label, {super.key, this.isLabelTopRight = true, this.size = 125, this.drawSecondLine = true});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        size: Size(size, size), // You can change these sizes
    painter: DiamondShapePainter(innerLabel: text, outerLabel: label, isLabelTopRight: isLabelTopRight, drawSecondLine: drawSecondLine)
    );
  }
}