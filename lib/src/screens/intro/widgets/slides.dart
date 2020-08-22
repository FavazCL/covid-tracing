import 'package:covid_app/src/controllers/slideshow_controller.dart';
import 'package:covid_app/src/screens/intro/widgets/slide.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class Slides extends StatelessWidget {
  const Slides({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SlideshowController>(
      init: SlideshowController(),
      builder: (_) {
        return Container(
            child: PageView(
          onPageChanged: (int value) {
            _.changeSlide(value);
          },
          children: [
            Slide(
                svg: 'assets/screens/intro/nature_screen.svg',
                title: 'COMIENZA',
                description:
                    'Activando tu aplicación para enviar o recibir semillas.'),
            Slide(
                svg: 'assets/screens/intro/social_distancing.svg',
                title: 'TRANSMITE',
                description:
                    'Las semillas generadas a otros dispositivos con la aplicación activada'),
            Slide(
              svg: 'assets/screens/intro/medical_care.svg',
              title: 'REPORTA',
              description:
                  'Si estas contagiado, informalo a través de la aplicación.',
            ),
            Slide(
              svg: 'assets/screens/intro/empty_street.svg',
              title: 'AÍSLATE',
              description:
                  'La aplicación te notificara si tuviste un contacto estrecho con un contagiado.',
            ),
          ],
        ));
      },
    );
  }
}
