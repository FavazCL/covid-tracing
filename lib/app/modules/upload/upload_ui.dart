import 'package:covid_app/app/global_widgets/header.dart';
import 'package:covid_app/app/global_widgets/image_header.dart';
import 'package:covid_app/app/global_widgets/paragraph.dart';
import 'package:covid_app/app/global_widgets/rounded_button.dart';
import 'package:covid_app/app/modules/request/request_controller.dart';
import 'package:covid_app/app/modules/upload/local_widgets/card_detail.dart';
import 'package:covid_app/app/theme/color_theme.dart';
import 'package:covid_app/app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class UploadUI extends StatefulWidget {
  const UploadUI({Key key}) : super(key: key);

  @override
  _UploadUIState createState() => _UploadUIState();
}

class _UploadUIState extends State<UploadUI> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return GetBuilder<RequestController>(
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
                    child: Header(title: 'COMPARTIR'),
                  ),
                ),
                Positioned(
                  top: responsive.hp(12),
                  child: Container(
                    width: responsive.width,
                    child: Column(
                      children: [
                        SizedBox(height: responsive.hp(2)),
                        ImageHeader(
                            path: 'assets/screens/upload/secure_data.svg',
                            size: responsive.dp(2.5)),
                        SizedBox(height: responsive.hp(3)),
                        Paragraph(
                            text:
                                'Comparte la información de los contactos almacenados en tu dispositivo.'),
                        SizedBox(height: responsive.hp(3)),
                        Paragraph(
                            text: 'La información de cada contacto contendrá:',
                            fontWeight: FontWeight.bold,
                            fontSize: 1.5),
                        SizedBox(height: responsive.hp(1)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: responsive.wp(2)),
                          child: CardDetail(
                            icon: Icons.date_range,
                            title: 'Día que se genero el contacto',
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: responsive.wp(2)),
                          child: CardDetail(
                            icon: Icons.list_alt,
                            title: 'Listado de semillas que coinciden con el diagnosticado',
                          )
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: responsive.wp(2)),
                          child: CardDetail(
                            icon: Icons.timer,
                            title: 'Duración del contacto',
                          )
                        ),
                        SizedBox(height: responsive.hp(2)),
                        Paragraph(
                            text:
                                'Recuerda que no se compartirá información personal que te pueda identificar.',
                            fontWeight: FontWeight.bold,
                            fontSize: 1.5),
                            SizedBox(height: responsive.hp(4)),
                            RoundedButton(text: 'Compartir', color: ColorsPalette.primary, onPressed: () {})
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
