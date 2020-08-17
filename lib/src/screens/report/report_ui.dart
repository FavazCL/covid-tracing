import 'package:covid_app/src/screens/report/widgets/pin_text_field.dart';
import 'package:covid_app/src/utils/colors.dart';
import 'package:covid_app/src/utils/responsive.dart';
import 'package:covid_app/src/widgets/paragraph.dart';
import 'package:covid_app/src/widgets/header.dart';
import 'package:covid_app/src/widgets/image_header.dart';
import 'package:covid_app/src/widgets/rounded_button.dart';
import 'package:flutter/material.dart';

class ReportUI extends StatelessWidget {
  static const routeName = 'report';
  const ReportUI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Scaffold(
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
                        ImageHeader(path: 'assets/screens/report/messaging.svg',
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
                          color: ColorsPalette.primary,
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
    );
  }
}
