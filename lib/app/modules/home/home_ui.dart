import 'package:covid_app/app/global_widgets/paragraph.dart';
import 'package:covid_app/app/routes/app_routes.dart';
import 'package:covid_app/app/theme/color_theme.dart';
import 'package:covid_app/app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../scan/local_widgets/circular_painter.dart';
import 'home_controller.dart';
import 'local_widgets/bottom_navigator.dart';
import 'local_widgets/header_painter.dart';
import '../scan/local_widgets/scan_button.dart';

class HomeUI extends StatelessWidget {
  const HomeUI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return GetBuilder<HomeController>(
      builder: (_) => SafeArea(
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
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: CustomPaint(
                    painter: CircularPainter(responsive: responsive),
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
                  top: responsive.dp(13),
                  left: responsive.dp(10),
                  child: Hero(
                      tag: 'scan',
                      child: ScanButton(
                        text: 'EMITIR',
                        scan: false,
                        onPressed: () => Get.toNamed(AppRoutes.SCAN),
                      )),
                ),
                Positioned(
                  top: responsive.dp(1),
                  right: responsive.dp(1),
                  child: Container(
                      child: IconButton(
                          iconSize: responsive.dp(2.5),
                          icon: Icon(Icons.cloud_upload,
                              color: ColorsPalette.secundary),
                          onPressed: (() {
                            print('To do..');
                          }))),
                ),
                Positioned(
                  top: responsive.dp(1),
                  left: responsive.dp(1),
                  child: Container(
                      child: IconButton(
                          iconSize: responsive.dp(2.5),
                          icon: Icon(Icons.settings,
                              color: ColorsPalette.secundary),
                          onPressed: () {
                            print('To do..');
                          })),
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
      ),
    );
  }
}
