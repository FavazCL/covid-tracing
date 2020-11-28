import 'package:covid_app/app/global_widgets/header.dart';
import 'package:covid_app/app/global_widgets/image_header.dart';
import 'package:covid_app/app/global_widgets/paragraph.dart';
import 'package:covid_app/app/global_widgets/rounded_button.dart';
import 'package:covid_app/app/modules/report/report_controller.dart';
import 'package:covid_app/app/routes/app_routes.dart';
import 'package:covid_app/app/theme/color_theme.dart';
import 'package:covid_app/app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'local_widgets/pin_text_field.dart';

class ReportUI extends StatelessWidget {
  static const routeName = 'report';
  const ReportUI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return GetBuilder<ReportController>(
      id: 'report',
      builder: (_) => Scaffold(
        body: GestureDetector(
          onDoubleTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Container(
              width: responsive.width,
              height: responsive.height,
              color: Colors.white,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: responsive.hp(0),
                    child: SafeArea(
                      child: Header(title: 'REPORTAR'),
                    ),
                  ),
                  Positioned(
                    top: responsive.hp(12),
                    child: Container(
                      width: responsive.width,
                      child: Column(
                        children: [
                          SizedBox(height: responsive.dp(2)),
                          ImageHeader(
                              path: 'assets/screens/report/messaging.svg',
                              size: 28),
                          SizedBox(height: responsive.dp(5)),
                          Paragraph(
                              text:
                                  'Ingresa el código otorgado por el responsable para su verificación'),
                          SizedBox(height: responsive.dp(5)),
                          PinTextField(),
                          SizedBox(height: responsive.dp(5)),
                          RoundedButton(
                            text: 'VERIFICAR',
                            color: (_.display) ? ColorsPalette.primary : ColorsPalette.gray,
                            onPressed: () {
                              if (_.display) {
                                print('Verificar work');
                              }
                            },
                          ),
                          SizedBox(height: responsive.dp(8)),
                          Paragraph(
                            text: '¿No tienes un código?',
                            fontSize: 1.5,
                            fontWeight: FontWeight.w600,
                          ),
                          SizedBox(height: responsive.dp(1)),
                          RoundedButton(
                            text: 'SOLICITAR AHORA',
                            color: Colors.redAccent,
                            onPressed: () => Get.toNamed(AppRoutes.REQUEST),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
