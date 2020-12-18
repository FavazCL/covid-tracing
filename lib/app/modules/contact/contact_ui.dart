import 'package:covid_app/app/global_widgets/header.dart';
import 'package:covid_app/app/global_widgets/paragraph.dart';
import 'package:covid_app/app/global_widgets/rounded_button.dart';
import 'package:covid_app/app/global_widgets/simple_card.dart';
import 'package:covid_app/app/modules/contact/contact_controller.dart';
import 'package:covid_app/app/modules/home/home_controller.dart';
import 'package:covid_app/app/theme/color_theme.dart';
import 'package:covid_app/app/utils/responsive.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    final HomeController _homeController = Get.put<HomeController>(HomeController());

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
                        SizedBox(height: responsive.hp(2.5)),
                        Paragraph(
                            text: '¿Qué es un contacto estrecho?',
                            fontSize: 2,
                            fontWeight: FontWeight.w600),
                        SizedBox(height: responsive.hp(1)),
                        Paragraph(
                            fontSize: 1.6,
                            text:
                                'Se considera un contacto estrecho cuando se cumplen una serie de condiciones, una de ellas es haber estado en contacto con una persona diagnosticada de covid.'),
                        SizedBox(height: responsive.hp(1)),
                        Divider(thickness: 1),
                        SizedBox(height: responsive.hp(1)),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('NÚMERO DE CONTACTOS ESTRECHOS',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: responsive.dp(1.6),
                                  )),
                              SizedBox(width: responsive.wp(3)),
                              Container(
                                  padding: EdgeInsets.all(responsive.dp(1)),
                                  decoration: BoxDecoration(
                                      color: ColorsPalette.primary,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8))),
                                  child: Text(_homeController.contacts.length.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        fontSize: responsive.dp(1.5),
                                      )))
                            ],
                          ),
                        ),
                        SizedBox(height: responsive.hp(1)),
                        (_homeController.contacts.length == 0) ? Container(
                          height:  responsive.hp(51),
                          alignment: Alignment.center,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/screens/contact/empty.svg', height: responsive.hp(20)),
                              SizedBox(height: responsive.hp(2)),
                              Text('No existen contactos estrechos.')
                            ],
                          ),
                        ) : Container(
                          height: responsive.hp(51),
                          width: double.infinity,
                          child: Scrollbar(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: _homeController.contacts.length,
                              itemBuilder: (context, index) {
                                return SimpleCard(
                                  title:
                                      'Fecha del contacto: ${formatDate(DateTime.fromMillisecondsSinceEpoch(_homeController.contacts[index].createdAt), [
                                    dd,
                                    '-',
                                    mm,
                                    '-',
                                    yyyy
                                  ])}',
                                  subtitle:
                                      'Duración del contacto: ${_homeController.contacts[index].duration.toString()} Minutos',
                                  trailing: Icons.healing,
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: responsive.dp(2)),
                        RoundedButton(
                            text: 'Ver sintomas',
                            color: ColorsPalette.primary,
                            onPressed: () => Get.toNamed('sympthom'))
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
