import 'package:covid_app/src/widgets/dot.dart';
import 'package:flutter/material.dart';

class Dots extends StatelessWidget {
  const Dots({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
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
