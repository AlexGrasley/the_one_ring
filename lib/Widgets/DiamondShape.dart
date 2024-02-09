import 'package:flutter/material.dart';
import '../Helpers/DiamondShapePainter.dart';

class DiamondShape extends StatelessWidget
{
  final String text;
  final String label;
  final LabelPosition labelPosition;
  final double size;
  final bool drawSecondLine;

  const DiamondShape(this.text, this.label, {super.key, this.labelPosition = LabelPosition.topRight, this.size = 125, this.drawSecondLine = true});

  @override
  Widget build(BuildContext context)
  {
    return CustomPaint(
      size: Size(size, size), // You can change these sizes
      painter: DiamondShapePainter(innerLabel: text, outerLabel: label, labelPosition: labelPosition, drawSecondLine: drawSecondLine, size: Size(size, size))
    );
  }
}