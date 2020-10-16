import 'package:flutter/material.dart';

import 'local_widgets/dots.dart';
import 'local_widgets/rectangle_button.dart';
import 'local_widgets/slides.dart';

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