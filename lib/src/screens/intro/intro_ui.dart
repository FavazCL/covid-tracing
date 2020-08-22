import 'package:covid_app/src/screens/intro/widgets/dots.dart';
import 'package:covid_app/src/screens/intro/widgets/rectangle_button.dart';
import 'package:covid_app/src/screens/intro/widgets/slides.dart';
import 'package:flutter/material.dart';

class IntroUI extends StatelessWidget {
  const IntroUI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Slides()
            ),
            Dots(),
            RectangleButton(text: 'DESLIZA')
          ],
        )
      ),
    );
  }
}