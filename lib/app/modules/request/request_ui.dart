import 'package:covid_app/app/global_widgets/header.dart';
import 'package:covid_app/app/global_widgets/image_header.dart';
import 'package:covid_app/app/global_widgets/paragraph.dart';
import 'package:covid_app/app/global_widgets/rounded_button.dart';
import 'package:covid_app/app/global_widgets/simple_card.dart';
import 'package:covid_app/app/modules/request/request_controller.dart';
import 'package:covid_app/app/theme/color_theme.dart';
import 'package:covid_app/app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'local_widgets/circle_button.dart';

class RequestUI extends StatefulWidget {
  static const routeName = 'request';
  const RequestUI({Key key}) : super(key: key);

  @override
  _RequestUIState createState() => _RequestUIState();
}

class _RequestUIState extends State<RequestUI> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return GetBuilder<RequestController>(
      id: 'request',
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
                    child: Header(title: 'SOLICITUD'),
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
                            path: 'assets/screens/request/going_up.svg',
                            size: responsive.dp(3)),
                        SizedBox(height: responsive.dp(5)),
                        Paragraph(
                            text:
                                'Solicita un código adjuntando o tomando una foto de su certificado médico.', fontSize: 1.8),
                        SizedBox(height: responsive.dp(5)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                CircleButton(
                                  path: 'assets/screens/request/icons/desktop.svg',
                                  sizeImage: 50,
                                  color: Color(0xffF0F0FF),
                                  onPressed: () => _.getImage(),
                                ),
                                SizedBox(height: responsive.hp(1)),
                                Text('Adjuntar', style: TextStyle(fontSize: responsive.dp(1.5)))
                              ],
                            ),
                            Column(
                              children: [
                                CircleButton(
                                  path:
                                      'assets/screens/request/icons/photography.svg',
                                  sizeImage: 50,
                                  color: Color(0xffF0F0FF),
                                  onPressed: () => _.takeImage(),
                                ),
                                SizedBox(height: responsive.hp(1)),
                                Text('Tomar foto', style: TextStyle(fontSize: responsive.dp(1.5)))
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: responsive.dp(4)),
                        (!_.image)
                            ? SimpleCard(
                                title: 'Aún no ha adjuntado la imagen.',
                                subtitle: 'Nombre no definido.',
                                colorCard: Colors.redAccent,
                                trailing: Icons.warning,
                                colorIcon: Colors.white,
                                colorTitle: Colors.white,
                                colorSubtitle: Colors.white,
                                overflow: false,
                              )
                            : SimpleCard(
                                title: 'Imagen adjuntada con éxito.',
                                subtitle: _.textImage,
                                colorCard: Colors.greenAccent,
                                trailing: Icons.check,
                                colorIcon: Colors.white,
                                overflow: true,
                              ),
                        Container(
                          padding: EdgeInsets.only(bottom: responsive.hp(2), left: responsive.wp(2)),
                          child: CheckboxListTile(
                            title: Text(
                              'Confirmo que el certificado no esta adulterado.',
                              style: TextStyle(fontWeight: FontWeight.w600, fontSize: responsive.dp(1.4)),
                            ),
                            controlAffinity: ListTileControlAffinity.platform,
                            dense: true,
                            value: _.checked,
                            onChanged: (bool value) {
                              _.setChecked = value;
                            },
                            activeColor: Colors.green,
                          ),
                        ),
                        RoundedButton(
                          text: 'ENVIAR POR CORREO',
                          color: (_.file != null && _.checked)
                              ? ColorsPalette.primary
                              : ColorsPalette.gray,
                          onPressed: () {
                            if (_.checked && (_.file != null)) {
                              _.sendEmail(_.file);
                            }
                          },
                        )
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
