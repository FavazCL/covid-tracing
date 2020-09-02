import 'package:covid_app/src/controllers/scan_controller.dart';
import 'package:covid_app/src/screens/home/widgets/circular_progress.dart';
import 'package:covid_app/src/screens/home/widgets/scan_button.dart';
import 'package:covid_app/src/utils/colors.dart';
import 'package:covid_app/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScanUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return GetBuilder<ScanController>(
      id: 'start',
      init: ScanController(),
      builder: (_) {
        print(_);
        return Scaffold(
            body: Container(
                color: ColorsPalette.dark,
                height: double.infinity,
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned(
                      top: responsive.dp(30.5),
                      left: responsive.dp(9),
                      child: Container(
                          width: responsive.dp(28),
                          height: responsive.dp(28),
                          child: CircularProgress(sigma: 4, opacity: 0.8)),
                    ),
                    Positioned(
                      top: responsive.dp(28.5),
                      left: responsive.dp(7),
                      child: Container(
                          width: responsive.dp(32),
                          height: responsive.dp(32),
                          child: CircularProgress(sigma: 10, opacity: 0.12)),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Hero(
                        tag: 'scan',
                        child: ScanButton(
                          text: 'ESCANEANDO',
                          onPressed: null,
                        ),
                      ),
                    ),
                  ],
                )));
      },
    );
  }
}
