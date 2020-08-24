import 'package:covid_app/src/screens/intro/widgets/dot.dart';
import 'package:covid_app/src/utils/responsive.dart';
import 'package:flutter/material.dart';

class Dots extends StatelessWidget {
  const Dots({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    
    return Container(
      width: double.infinity,
      height: responsive.dp(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Dot(position: 0),
          Dot(position: 1),
          Dot(position: 2),
          Dot(position: 3)
        ],
      ),
    );
  }
}
