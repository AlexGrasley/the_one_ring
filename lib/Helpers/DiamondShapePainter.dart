import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class DiamondShapePainter extends CustomPainter {
  String? innerLabel;
  String? outerLabel;
  bool? isLabelTopRight;
  bool drawSecondLine;

  DiamondShapePainter({
    this.innerLabel,
    this.outerLabel,
    this.isLabelTopRight,
    this.drawSecondLine = true,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Draw a diamond
    var path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height / 2)
      ..lineTo(size.width / 2, size.height)
      ..lineTo(0, size.height / 2)
      ..close();

    var paint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawPath(path, paint); // Original diamond

    // Draw a second diamond slightly larger to create a double-line effect
    if(drawSecondLine){
      path.reset();
      path
        ..moveTo(size.width / 2, 0 - 5)
        ..lineTo(size.width + 5, size.height / 2)
        ..lineTo(size.width / 2, size.height + 5)
        ..lineTo(0 - 5, size.height / 2)
        ..close();
      canvas.drawPath(path, paint);
    }


    var textStyle = ui.TextStyle(
      color: Colors.black,
      fontSize: 26,
    );// Slightly larger diamond for double-line effect

    // Draw `innerLabel` at center of diamond
    if (innerLabel != null && innerLabel!.isNotEmpty) {
      var paragraphStyle = ui.ParagraphStyle(textAlign: TextAlign.center);
      var paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
        ..pushStyle(textStyle)
        ..addText(innerLabel!);
      var paragraph = paragraphBuilder.build()
        ..layout(ui.ParagraphConstraints(width: size.width));
      var offset = Offset(size.width / 2 - paragraph.width / 2, size.height / 2 - paragraph.height / 2);
      canvas.drawParagraph(paragraph, offset);
    }

    textStyle = ui.TextStyle(
      color: Colors.black,
      fontSize: 10,
    );

    // Draw `outerLabel` at top right or bottom left
    if (outerLabel != null && outerLabel!.isNotEmpty) {
      var paragraphStyle = ui.ParagraphStyle(textAlign: TextAlign.left);
      var paragraphBuilder = ui.ParagraphBuilder(paragraphStyle)
        ..pushStyle(textStyle)
        ..addText(outerLabel!);
      var paragraph = paragraphBuilder.build()
        ..layout(ui.ParagraphConstraints(width: size.width));
      var offset = isLabelTopRight!
          ? Offset(size.width - 10, 0)
          : Offset(paragraph.width - size.width, size.height - paragraph.height);
      canvas.drawParagraph(paragraph, offset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}