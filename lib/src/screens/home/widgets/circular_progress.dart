import 'dart:ui';

import 'package:covid_app/src/screens/home/widgets/radial_progress.dart';
import 'package:flutter/material.dart';

class CircularProgress extends StatefulWidget {
  final double sigma, opacity;
  CircularProgress({Key key, @required this.sigma, @required this.opacity})
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
    controller.repeat();

    return Container(
        child: AnimatedBuilder(
            animation: controller,
            child: CustomPaint(
              painter: RadialProgress(
                  porcentaje: porcentaje,
                  sigma: widget.sigma,
                  opacity: widget.opacity),
            ),
            builder: (BuildContext context, Widget circle) {
              return CustomPaint(
                painter: RadialProgress(
                    porcentaje: controller.value * 100,
                    sigma: widget.sigma,
                    opacity: widget.opacity),
              );
            }));
  }
}
