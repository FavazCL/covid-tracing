import 'package:covid_app/src/utils/colors.dart';
import 'package:covid_app/src/utils/responsive.dart';
import 'package:flutter/material.dart';

class CircularPainter extends CustomPainter {
  final Responsive responsive;

  CircularPainter({@required this.responsive});

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
      Offset(responsive.dp(22.5), responsive.dp(25.5)),
      responsive.dp(13),
      lapiz
    );
    
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

}