import 'package:covid_app/app/global_widgets/paragraph.dart';
import 'package:covid_app/app/global_widgets/rounded_button.dart';
import 'package:covid_app/app/theme/color_theme.dart';
import 'package:covid_app/app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'local_widgets/circular_progress.dart';
import 'local_widgets/scan_button.dart';
import 'scan_controller.dart';

class ScanUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return GetBuilder<ScanController>(
      id: 'start',
      builder: (_) {
        return Scaffold(
            body: Container(
                color: ColorsPalette.dark,
                height: double.infinity,
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned(
                      top: responsive.dp(10),
                      child: Container(
                        width: responsive.width,
                        child: Text('FUNCIONANDO',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: responsive.dp(2.5),
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    Positioned(
                      top: responsive.dp(14),
                      child: Container(
                          width: responsive.width,
                          child: Paragraph(
                            text:
                                'El dispositivo esta enviando y recibiendo semillas.',
                            color: Colors.white,
                          )),
                    ),
                    CircularProgress(sigma: 5, opacity: 0.4, radius: 12.5),
                    CircularProgress(sigma: 10, opacity: 0.12, radius: 14.0),
                    Container(
                      alignment: Alignment.center,
                      child: Hero(
                        tag: 'scan',
                        child: ScanButton(
                          scan: true,
                          text: 'EMITIENDO',
                          onPressed: null,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: responsive.dp(10),
                      left: responsive.dp(13),
                      child: Container(
                        child: RoundedButton(
                          onPressed: () => Get.back(),
                          text: 'DETENER',
                          color: ColorsPalette.primary,
                        ),
                      ),
                    ),
                  ],
                )));
      },
    );
  }
}
