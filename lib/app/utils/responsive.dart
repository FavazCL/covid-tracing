

import 'package:flutter/widgets.dart';
import 'dart:math' as math;

class Responsive {
  final double width, height, diagonal;

  Responsive({
    @required this.width, 
    @required this.height, 
    @required this.diagonal
  });

  factory Responsive.of(BuildContext context) {
    final MediaQueryData data = MediaQuery.of(context);
    final size = data.size;
    final diagonal = math.sqrt(math.pow(size.width, 2) + math.pow(size.height, 2));
    
    return Responsive(width: size.width, height: size.height, diagonal: diagonal);
  }

  double wp(double percent) => this.width * percent / 100;
  double hp(double percent) => this.height * percent / 100;
  double dp(double percent) => this.diagonal * percent / 100;
  
}