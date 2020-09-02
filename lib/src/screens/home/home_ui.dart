import 'package:covid_app/src/screens/home/widgets/bottom_navigator.dart';
import 'package:covid_app/src/screens/home/widgets/header_painter.dart';
import 'package:covid_app/src/screens/home/widgets/scan_button.dart';
import 'package:covid_app/src/screens/home/widgets/scan_ui.dart';
import 'package:covid_app/src/utils/colors.dart';
import 'package:covid_app/src/utils/responsive.dart';
import 'package:covid_app/src/widgets/header.dart';
import 'package:covid_app/src/widgets/paragraph.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeUI extends StatelessWidget {
  static const routeName = 'home';
  const HomeUI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                child: CustomPaint(
                  painter: HeaderPainter(),
                ),
              ),
              Positioned(
                top: responsive.dp(2),
                child: Container(
                  width: responsive.width,
                  child: Text('Covid Tracing',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: responsive.dp(2.5))),
                ),
              ),
              Positioned(
                top: responsive.dp(15),
                left: responsive.dp(10),
                child: Hero(
                  tag: 'scan', 
                  child: ScanButton(
                    onPressed: () => Get.to(ScanUI()),
                  )
                ),
              ),
              Positioned(
                bottom: responsive.dp(16),
                child: Container(
                  width: responsive.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Icon(
                          Icons.check,
                          size: responsive.dp(5),
                        ),
                      ),
                      SizedBox(height: responsive.dp(2)),
                      Container(
                        child: Text('No hay indicios de contacto',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: responsive.dp(2))),
                      ),
                      SizedBox(height: responsive.dp(2)),
                      Paragraph(
                          fontSize: responsive.dp(0.2),
                          text:
                              'Tu dispositivo no ha tenido contacto con una persona contagiada, sigue cuidandote.')
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomSheet: BottomNavigator(),
      ),
    );
  }
}
