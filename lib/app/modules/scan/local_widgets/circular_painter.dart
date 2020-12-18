import 'package:covid_app/app/theme/color_theme.dart';
import 'package:covid_app/app/utils/responsive.dart';
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
      Offset(responsive.wp(52), responsive.hp(27.8)),
      responsive.dp(12.9),
      lapiz
    );
    
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

}