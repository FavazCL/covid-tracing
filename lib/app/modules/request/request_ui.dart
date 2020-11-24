import 'dart:io';

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
import 'package:image_picker/image_picker.dart';

import 'local_widgets/circle_button.dart';

class RequestUI extends StatefulWidget {
  static const routeName = 'request';
  const RequestUI({Key key}) : super(key: key);

  @override
  _RequestUIState createState() => _RequestUIState();
}

class _RequestUIState extends State<RequestUI> {
  var _checked = false;
  var textImage = '';
  final picker = ImagePicker();
  File _image;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(pickedFile.path);

      if (_image.path != null) {
        final text = _image.path.split("/");
        textImage = text.last;
      }
    });
  }

  Future takeImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);

      if (_image.path != null) {
        final text = _image.path.split("/");
        textImage = text.last;
      }
    });
  }

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
                            size: 28),
                        SizedBox(height: responsive.dp(5)),
                        Paragraph(
                            text:
                                'Adjunta una imagen o toma una foto de tu certificado médico que acredite tu positividad.'),
                        SizedBox(height: responsive.dp(5)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleButton(
                              path: 'assets/screens/request/icons/desktop.svg',
                              sizeImage: 50,
                              color: Color(0xffF0F0FF),
                            ),
                            CircleButton(
                              path:
                                  'assets/screens/request/icons/photography.svg',
                              sizeImage: 50,
                              color: Color(0xffF0F0FF),
                            )
                          ],
                        ),
                        SizedBox(height: responsive.dp(5)),
                        //Without Image
                        SimpleCard(
                          title: 'Aún no ha adjuntado la imagen.',
                          subtitle: 'Nombre no definido.',
                          colorCard: Colors.redAccent,
                          trailing: Icons.warning,
                          colorIcon: Colors.white,
                        ),

                        // With Image
                        /*SimpleCard(
                          title: 'Imagen adjuntada con éxito.',
                          subtitle: 'nombre_archivo.jpg',
                          colorCard: Colors.greenAccent,
                          trailing: Icons.check,
                          colorIcon: Colors.white,
                        ),*/
                        Container(
                          padding: EdgeInsets.only(bottom: 20),
                          child: CheckboxListTile(
                            title: Text(
                              'Confirmo que el certificado no esta adulterado.',
                            ),
                            controlAffinity: ListTileControlAffinity.platform,
                            dense: true,
                            value: _checked,
                            onChanged: (bool value) {
                              setState(() {
                                _checked = value;
                              });
                            },
                            activeColor: Colors.green,
                          ),
                        ),
                        RoundedButton(
                          text: 'ENVIAR POR CORREO',
                          color: ColorsPalette.primary,
                          onPressed: () {
                            if (_checked && (_image != null)) {
                              _.sendEmail(_image);
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

  // ignore: unused_element
  Widget _conditions(Responsive responsive) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: responsive.dp(2)),
      child: CheckboxListTile(
        title: Text(
          'Confirmo que el certificado no esta adulterado.',
          style: TextStyle(
              fontFamily: 'monse',
              fontWeight: FontWeight.w600,
              fontSize: responsive.dp(1.3)),
        ),
        controlAffinity: ListTileControlAffinity.leading,
        dense: true,
        value: _checked,
        activeColor: Colors.greenAccent,
        secondary: Icon(Icons.sms_failed, color: Colors.redAccent),
        onChanged: (bool value) {
          setState(() {
            _checked = value;
          });
        },
      ),
    );
  }
}
