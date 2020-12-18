import 'package:covid_app/app/global_widgets/paragraph.dart';
import 'package:covid_app/app/global_widgets/rounded_button.dart';
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
      id: 'home',
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
                  top: responsive.hp(2),
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
                  top: responsive.hp(14),
                  left: responsive.wp(22.5),
                  child: Hero(
                      tag: 'scan',
                      child: ScanButton(
                        text: 'EMITIR',
                        scan: false,
                        onPressed: () => Get.toNamed(AppRoutes.SCAN),
                      )),
                ),
                Positioned(
                  top: responsive.hp(1),
                  right: responsive.wp(1),
                  child: Container(
                      child: IconButton(
                          iconSize: responsive.dp(2.5),
                          icon: Icon(Icons.cloud_upload,
                              color: ColorsPalette.secundary),
                          onPressed: (() => Get.toNamed(AppRoutes.UPLOAD)))),
                ),
                Positioned(
                  top: responsive.hp(1),
                  left: responsive.wp(1),
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
                  bottom: responsive.hp(15),
                  child: Container(
                    width: responsive.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: (_.contacts.length < 1)
                              ? Icon(
                                  Icons.check,
                                  size: responsive.dp(5),
                                  color: Colors.greenAccent,
                                )
                              : Icon(Icons.warning,
                                  size: responsive.dp(5),
                                  color: Colors.orangeAccent),
                        ),
                        SizedBox(height: responsive.dp(2)),
                        Container(
                          child: (_.contacts.length < 1)
                              ? Text('No hay indicios de contacto',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: responsive.dp(2)))
                              : Text(
                                  'Tienes ${_.contacts.length} ${(_.contacts.length == 1) ? 'contacto estrecho' : 'contactos estrechos'}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: responsive.dp(2))),
                        ),
                        SizedBox(height: responsive.dp(2)),
                        (_.contacts.length < 1) ? Paragraph(
                            fontSize: responsive.dp(0.2),
                            text:
                                'Tu dispositivo no ha tenido contacto con una persona contagiada, sigue cuidandote.') : Paragraph(
                            fontSize: responsive.dp(0.2),
                            text:
                                'Tu dispositivo ha tenido contacto con una persona contagiada, cuidate.'),
                                SizedBox(height: responsive.dp(2)),
                        (_.contacts.length > 0) ? RoundedButton(
                            text: 'Ver sintomas',
                            color: ColorsPalette.primary,
                            onPressed: () => Get.toNamed('sympthom')) : SizedBox.shrink()
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
