import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

enum LabelPosition {
  topRight,
  bottomLeft,
  bottomRight
}

class DiamondShapePainter extends CustomPainter {
  String? innerLabel;
  String? outerLabel;
  LabelPosition? labelPosition;
  bool drawSecondLine;
  var random = Random();
  ui.Picture? picture;
  Size size;

  DiamondShapePainter({
    this.innerLabel,
    this.outerLabel,
    this.labelPosition = LabelPosition.topRight,
    this.drawSecondLine = true,
    required this.size,
  }){
    picture = _drawElements(size);
  }

  @override
  void paint(Canvas canvas, Size size){
    canvas.drawPicture(picture!);
  }

  ui.Picture _drawElements(Size size) {
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);

    _drawSegmentedLine(
      canvas,
      Offset(size.width / 2, 0),
      Offset(size.width, size.height / 2),
    );
    _drawSegmentedLine(
      canvas,
      Offset(size.width, size.height / 2),
      Offset(size.width / 2, size.height),
    );
    _drawSegmentedLine(
      canvas,
      Offset(size.width / 2, size.height),
      Offset(0, size.height / 2),
    );
    _drawSegmentedLine(
      canvas,
      Offset(0, size.height / 2),
      Offset(size.width / 2, 0),
    );

    // Draw a second diamond slightly larger to create a double-line effect
    _drawSegmentedLine(
      canvas,
      Offset(size.width / 2, -5),
      Offset(size.width + 5, size.height / 2),
    );
    _drawSegmentedLine(
      canvas,
      Offset(size.width + 5, size.height / 2),
      Offset(size.width / 2, size.height + 5),
    );
    _drawSegmentedLine(
      canvas,
      Offset(size.width / 2, size.height + 5),
      Offset(-5, size.height / 2),
    );
    _drawSegmentedLine(
      canvas,
      Offset(-5, size.height / 2),
      Offset(size.width / 2, -5),
    );


    var textStyle = ui.TextStyle(
      color: Colors.white,
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
      color: Colors.white,
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

      ui.Offset offset;

      switch(labelPosition){
        case LabelPosition.topRight:
          offset = Offset(size.width - 7, 0);
          break;
        case LabelPosition.bottomRight:
          offset = Offset(size.width - 7, size.height - paragraph.height);
          break;
        case LabelPosition.bottomLeft:
          offset = Offset(paragraph.width - size.width, size.height - paragraph.height);
          break;
        case null:
          offset = Offset(size.width - 10, 0);
          break;
      }

      canvas.drawParagraph(paragraph, offset);
    }

    return recorder.endRecording();
  }

  void _drawSegmentedLine(Canvas canvas, Offset p1, Offset p2) {
    var count = 50; // Number of segments - increase for smoother gradient
    var stepX = (p2.dx - p1.dx) / count;
    var stepY = (p2.dy - p1.dy) / count;
    for (var i = 0; i < count; i++) {
      var start = Offset(p1.dx + stepX * i, p1.dy + stepY * i);
      var end = Offset(p1.dx + stepX * (i + 1), p1.dy + stepY * (i + 1));
      var paint = Paint()
        ..color = Colors.red
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round
        ..strokeWidth = random.nextDouble() * 2; // Thickness randomly varies from 1.0 to 5.0
      canvas.drawLine(start, end, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}