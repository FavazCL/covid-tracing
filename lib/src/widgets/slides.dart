import 'package:covid_app/src/controllers/slideshow_controller.dart';
import 'package:covid_app/src/widgets/slide.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class Slides extends StatelessWidget {
  const Slides({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SlideshowController>(
      init: SlideshowController(),
      builder: (_) {
        print('slideshowController');
        return Container(
          child: PageView(
          onPageChanged: (int value) {
            print('xd');
            _.changeSlide(value);
          },
          children: [
            Slide(svg: 'assets/screens/intro/empty_street.svg'),
            Slide(svg: 'assets/screens/intro/medical_care.svg'),
            Slide(svg: 'assets/screens/intro/nature_screen.svg'),
            Slide(svg: 'assets/screens/intro/social_distancing.svg'),
          ],
        ));
      },
    );
  }
}
