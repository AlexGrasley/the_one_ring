import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class HandDrawnDivider extends StatelessWidget {
  final double thickness;
  final Color color;

  const HandDrawnDivider({super.key, this.thickness = 2.0, this.color = Colors.blueGrey});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        size: Size(double.infinity, thickness),
        painter: _HandDrawnPainter(thickness: thickness, color: color),
      );
  }
}

class _HandDrawnPainter extends CustomPainter {
  final double thickness;
  final Color color;
  final Random _random = Random();
  ui.Picture? picture;

  _HandDrawnPainter({required this.thickness, required this.color});

  @override
  void paint(Canvas canvas, Size size){
    picture ??= _drawElements(size);
    canvas.drawPicture(picture!);
  }

  ui.Picture _drawElements(Size size) {
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);

    final paint = Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..strokeWidth = thickness;

    final step = size.width / 400;

    for (var i = 0.0; i < size.width; i += step) {
      paint.strokeWidth = _random.nextDouble() * thickness + 2;

      if(step % 2 == 0){
        final path = Path()
          ..moveTo(size.width / 2, 0)
          ..cubicTo(3 * size.width / 4, size.height / 4, 3 * size.width / 4,
              3 * size.height / 4, size.width / 2, size.height)
          ..cubicTo(size.width / 4, 3 * size.height / 4, size.width / 4,
              size.height / 4, size.width / 2, 0);

        canvas.drawPath(path, paint);
      }

      final startPoint = Offset(i, size.height / 2);
      final endPoint = Offset(i + step, size.height / 2);

      canvas.drawLine(startPoint, endPoint, paint);
    }

    return recorder.endRecording();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}