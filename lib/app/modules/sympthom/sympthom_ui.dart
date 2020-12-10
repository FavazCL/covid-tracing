import 'package:covid_app/app/global_widgets/header.dart';
import 'package:covid_app/app/global_widgets/paragraph.dart';
import 'package:covid_app/app/global_widgets/rounded_button.dart';
import 'package:covid_app/app/modules/sympthom/sympthom_controller.dart';
import 'package:covid_app/app/theme/color_theme.dart';
import 'package:covid_app/app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'local_widgets/symp_card.dart';

class SympthomUI extends StatelessWidget {
  static const routeName = 'sympthom';
  const SympthomUI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return GetBuilder<SympthomController>(
      builder: (_) => Scaffold(
        body: SingleChildScrollView(
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
                    child: Header(title: 'SÍNTOMAS'),
                  ),
                ),
                Positioned(
                  top: responsive.hp(12),
                  child: Container(
                    width: responsive.width,
                    child: Column(
                      children: [
                        SizedBox(height: responsive.dp(5)),
                        Paragraph(
                          text: 'RECONOZCA SUS PRINCIPALES SÍNTOMAS',
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                        ),
                        SizedBox(height: responsive.dp(2)),
                        SympCard(
                          path: 'assets/screens/sympthom/icons/lungs.svg',
                          text: 'DIFICULTAD RESPIRATORIA',
                          fontSize: responsive.dp(1.8),
                        ),
                        SizedBox(height: responsive.dp(2)),
                        SympCard(
                          path: 'assets/screens/sympthom/icons/fever.svg',
                          text: 'FIEBRE ALTA SOBRE 38 ºC',
                          fontSize: responsive.dp(1.8),
                        ),
                        SizedBox(height: responsive.dp(2)),
                        SympCard(
                          path: 'assets/screens/sympthom/icons/symptom.svg',
                          text: 'TOS',
                          fontSize: responsive.dp(1.8),
                        ),
                        SizedBox(height: responsive.dp(2)),
                        Paragraph(
                          text: 'Si presenta alguno de estos síntomas, diríjase al Servicio de Urgencias más cercano alertando sobre ellos.',
                          fontSize: responsive.dp(0.18),
                          color: Colors.black45,
                        ),
                        SizedBox(height: responsive.dp(5)),
                        Paragraph(
                          text: 'SI AÚN TIENE DUDAS, LLAME A \nSALUD RESPONDE',
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                        ),
                        SizedBox(height: responsive.dp(2)),
                        RoundedButton(text: 'LLAMAR AHORA', color: ColorsPalette.primary, onPressed: () => _.launchTEL()),
                        SizedBox(height: responsive.dp(2)),
                        Paragraph(
                          text: 'Disponible las 24 horas del día.',
                          fontSize: responsive.dp(0.18),
                          color: Colors.black45,
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
