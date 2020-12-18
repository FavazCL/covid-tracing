import 'package:covid_app/app/global_widgets/image_header.dart';
import 'package:covid_app/app/global_widgets/paragraph.dart';
import 'package:covid_app/app/global_widgets/rounded_button.dart';
import 'package:covid_app/app/modules/report/report_controller.dart';
import 'package:covid_app/app/routes/app_routes.dart';
import 'package:covid_app/app/theme/color_theme.dart';
import 'package:covid_app/app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class SuccessRequestUI extends StatelessWidget {
  const SuccessRequestUI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return GetBuilder<ReportController>(
        builder: (_) => Scaffold(
              body: SingleChildScrollView(
                child: SafeArea(
                  child: Container(
                    width: responsive.width,
                    color: Colors.white,
                    child: Column(
                      children: [
                        SizedBox(height: responsive.hp(5)),
                        Text('Solicitud exitosa',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorsPalette.primary,
                                fontSize: responsive.dp(3))),
                        SizedBox(height: responsive.hp(5)),
                        ImageHeader(
                            path: 'assets/screens/others/confirmed.svg',
                            size: responsive.dp(3)),
                        SizedBox(height: responsive.hp(5)),
                        Paragraph(
                            text:
                                'Se ha realizado una solicitud de código, recuerda que el encargado verificará el certificado y te enviará el código al correo ingresado.'),
                        SizedBox(height: responsive.hp(8)),
                        RoundedButton(
                            text: 'Volver al inicio',
                            color: ColorsPalette.primary,
                            onPressed: () => Get.offAllNamed(AppRoutes.HOME))
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }
}
