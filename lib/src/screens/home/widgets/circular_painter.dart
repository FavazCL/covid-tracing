import 'package:covid_app/src/utils/colors.dart';
import 'package:flutter/material.dart';

class CircularPainter extends CustomPainter {

  double _sigma = 4;

  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = Paint();
    lapiz.color = ColorsPalette.primary;
    lapiz.style = PaintingStyle.stroke;
    lapiz.strokeCap = StrokeCap.round;
    lapiz.strokeWidth = 0.5;
    lapiz.maskFilter = MaskFilter.blur(BlurStyle.normal, _sigma);

    canvas.drawCircle(
      Offset(size.width * 0.49, size.height * 0.33),
      size.width * 0.30,
      lapiz
    );
    
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

}