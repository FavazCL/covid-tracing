import 'package:covid_app/app/global_widgets/header.dart';
import 'package:covid_app/app/global_widgets/image_header.dart';
import 'package:covid_app/app/global_widgets/paragraph.dart';
import 'package:covid_app/app/global_widgets/rounded_button.dart';
import 'package:covid_app/app/global_widgets/simple_card.dart';
import 'package:covid_app/app/modules/contact/contact_controller.dart';
import 'package:covid_app/app/modules/request/local_widgets/success_request.dart';
import 'package:covid_app/app/modules/request/request_controller.dart';
import 'package:covid_app/app/theme/color_theme.dart';
import 'package:covid_app/app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class ContactUI extends StatefulWidget {
  static const routeName = 'request';
  const ContactUI({Key key}) : super(key: key);

  @override
  _ContactUIState createState() => _ContactUIState();
}

class _ContactUIState extends State<ContactUI> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return GetBuilder<ContactController>(
      id: 'contact',
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
                    child: Header(title: 'CONTACTOS'),
                  ),
                ),
                Positioned(
                  top: responsive.hp(12),
                  child: Container(
                    width: responsive.width,
                    child: Column(
                      children: [
                        SizedBox(height: responsive.dp(2.5)),
                        Paragraph(
                            text: '¿Qué es un contacto estrecho?',
                            fontSize: 1.8,
                            fontWeight: FontWeight.w600),
                        SizedBox(height: responsive.dp(1)),
                        Paragraph(
                          fontSize: 1.5,
                            text:
                                'Se considera un contacto estrecho cuando se cumplen una serie de condiciones, una de ellas es haber estado en contacto con una persona diagnosticada de covid.'),
                        SizedBox(height: responsive.dp(2)),
                        Divider(),
                        SizedBox(height: responsive.dp(2)),
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
