import 'package:covid_app/src/widgets/dots.dart';
import 'package:covid_app/src/widgets/slides.dart';
import 'package:flutter/material.dart';

class SlideShow extends StatelessWidget {
  const SlideShow({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Slides()
            ),
            Dots()
          ],
        )
      ),
    );
  }
}
