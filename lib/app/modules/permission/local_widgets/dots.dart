import 'package:covid_app/app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'dot.dart';

class Dots extends StatelessWidget {
  const Dots({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    
    return Container(
      width: double.infinity,
      height: responsive.dp(18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Dot(position: 0),
          Dot(position: 1),
          Dot(position: 2),
        ],
      ),
    );
  }
}
