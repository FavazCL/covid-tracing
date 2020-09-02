import 'package:covid_app/src/utils/colors.dart';
import 'package:flutter/material.dart';

class HeaderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Rect.fromCircle(
      center: Offset(0, 155.0),
      radius: 180
    );

    final Gradient gradiente = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: <Color>[
        ColorsPalette.background,
        ColorsPalette.dark,
      ],
      stops: [
        0.1,
        0.3,
      ]
    );

    final lapiz = Paint()..shader = gradiente.createShader(rect);

    lapiz.color = ColorsPalette.primary;
    lapiz.style = PaintingStyle.fill;
    lapiz.strokeWidth = 20;

    final path = Path();

    path.lineTo(0, size.height * 0.4);
    path.quadraticBezierTo(
        size.width * 0.5,
        size.height * 0.68,
        size.width,
        size.height *
            0.4); 
    path.lineTo(size.width, 0);

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

}