import 'dart:math';
import 'package:covid_app/src/utils/colors.dart';
import 'package:flutter/material.dart';

class RadialProgress extends CustomPainter {
  final double porcentaje, sigma, opacity;

  RadialProgress(
      {@required this.opacity,
      @required this.sigma,
      @required this.porcentaje});

  @override
  void paint(Canvas canvas, Size size) {
    // Circulo completado
    final paint = Paint();
    paint.strokeWidth = 10;
    paint.color = ColorsPalette.primary.withOpacity(opacity);
    paint.style = PaintingStyle.stroke;
    paint.maskFilter = MaskFilter.blur(BlurStyle.normal, sigma);

    // Arco
    final paintArco = Paint();
    paintArco.strokeWidth = 10;
    paintArco.color = ColorsPalette.primary.withOpacity(opacity);
    paintArco.style = PaintingStyle.stroke;
    paintArco.strokeCap = StrokeCap.round;
    paint.maskFilter = MaskFilter.blur(BlurStyle.normal, sigma);

    Offset center = Offset(size.width / 2, size.height / 2);
    double radio = min(size.width / 2, size.height / 2);
    double arcAngle = 2 * pi * (porcentaje / 100);

    canvas.drawCircle(center, radio, paint);

    // Parte que se deberá ir llenando
    canvas.drawArc(Rect.fromCircle(center: center, radius: radio), -pi / 2,
        arcAngle, false, paintArco);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
