import 'package:covid_app/app/global_widgets/header.dart';
import 'package:covid_app/app/theme/color_theme.dart';
import 'package:covid_app/app/utils/responsive.dart';
import 'package:flutter/material.dart';

import 'local_widgets/question.dart';

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
                        fontSize: responsive.dp(2.5))),
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
                        iconData: Icons.location_on),
                    SizedBox(height: responsive.dp(2)),
                    Question(
                        title:
                            'El código para reportar no funciona',
                        description:
                            'Debes comunicarte con el soporte de la plataforma contacto@contacto.com',
                        iconData: Icons.qr_code),
                    SizedBox(height: responsive.dp(2)),
                    Question(
                        title:
                            '¿Es necesario tener la aplicación en primer plano para que funcione?',
                        description:
                            'No, al momento de cerrar la aplicación esta trabajará en segundo plano.',
                        iconData: Icons.smartphone),
                    SizedBox(height: responsive.dp(2)),
                    Question(
                        title:
                            '¿Esta aplicación tiene acceso mis fotos, archivos, etc?',
                        description:
                            'No, esta aplicación solo almacena las semillas en la memoria interna de la aplicación.',
                        iconData: Icons.storage),
                    SizedBox(height: responsive.dp(2)),
                    Question(
                        title:
                            '¿Esta aplicación expone mi información personal?',
                        description:
                            'No, solo emite una semilla encriptada que cambia cada día.',
                        iconData: Icons.privacy_tip),
                    SizedBox(height: responsive.dp(2)),
                    Question(
                        title:
                            '¿Cuál es la información de contacto?',
                        description:
                            'Correo: contacto@correo.com \n Web: covidtracing.cl',
                        iconData: Icons.info),
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
