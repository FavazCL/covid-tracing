import 'package:covid_app/src/screens/faq/widgets/box.dart';
import 'package:covid_app/src/screens/faq/widgets/custom_tile.dart';
import 'package:covid_app/src/screens/faq/widgets/question.dart';
import 'package:covid_app/src/utils/colors.dart';
import 'package:covid_app/src/utils/responsive.dart';
import 'package:covid_app/src/widgets/header.dart';
import 'package:flutter/material.dart';

class FaqUI extends StatelessWidget {
  const FaqUI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
            children: [
              Header(title: 'AYUDA'),
              Container(
                padding: EdgeInsets.only(top: responsive.dp(2), bottom: responsive.dp(1)),
                alignment: Alignment.center,
                child: Text('PREGUNTAS FRECUENTES',
                    style: TextStyle(
                        color: ColorsPalette.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: responsive.dp(3))),
              ),
              Container(
                height: responsive.dp(68),
                color: Colors.white,
                child: ListView(
                  children: [
                    SizedBox(height: responsive.dp(2)),
                    Question(
                        title:
                            '¿Si desactivo el bluetooth seguira funcionando?',
                        description:
                            'No, siempre debe estar activo si decea recibir o enviar semillas.',
                        iconData: Icons.bluetooth),
                    SizedBox(height: responsive.dp(2)),
                    Question(
                        title:
                            '¿Es necesario activar el GPS?',
                        description:
                            'No, aunque la activación de este mejora aun más la precisión del bluetooth.',
                        iconData: Icons.bluetooth),
                    SizedBox(height: responsive.dp(2)),
                    Question(
                        title:
                            'El código para reportar no funciona',
                        description:
                            'Debes comunicarte con el soporte de la plataforma contacto@contacto.com',
                        iconData: Icons.bluetooth),
                    SizedBox(height: responsive.dp(2)),
                    Question(
                        title:
                            '¿Si desactivo el bluetooth seguira funcionando?',
                        description:
                            'No, siempre debe estar activo si decea recibir o enviar semillas.',
                        iconData: Icons.bluetooth),
                    SizedBox(height: responsive.dp(2)),
                    Question(
                        title:
                            '¿Si desactivo el bluetooth seguira funcionando?',
                        description:
                            'No, siempre debe estar activo si decea recibir o enviar semillas.',
                        iconData: Icons.bluetooth),
                    SizedBox(height: responsive.dp(2)),
                    Question(
                        title:
                            '¿Si desactivo el bluetooth seguira funcionando?',
                        description:
                            'No, siempre debe estar activo si decea recibir o enviar semillas.',
                        iconData: Icons.bluetooth),
                    SizedBox(height: responsive.dp(2)),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
