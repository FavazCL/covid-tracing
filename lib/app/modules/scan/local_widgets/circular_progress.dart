import 'dart:ui';
import 'package:covid_app/app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'radial_progress.dart';

class CircularProgress extends StatefulWidget {
  final double sigma, opacity, radius;
  CircularProgress(
      {Key key, @required this.sigma, @required this.opacity, this.radius})
      : super(key: key);

  @override
  _CircularProgressState createState() => _CircularProgressState();
}

class _CircularProgressState extends State<CircularProgress>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  double porcentaje = 0.0;
  double nuevoPorcentaje = 0.0;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 4500));

    controller.addListener(() {
      porcentaje = lerpDouble(porcentaje, nuevoPorcentaje, controller.value);
    });

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    controller.repeat();

    return Container(
        height: responsive.height,
        width: responsive.width,
        child: AnimatedBuilder(
            animation: controller,
            builder: (BuildContext context, Widget circle) {
              return CustomPaint(
                painter: RadialProgress(
                    responsive: responsive,
                    porcentaje: controller.value * 100,
                    sigma: widget.sigma,
                    opacity: widget.opacity,
                    radius: widget.radius),
              );
            }));
  }
}
