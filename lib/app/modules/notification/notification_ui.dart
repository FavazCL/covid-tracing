import 'package:covid_app/app/global_widgets/header.dart';
import 'package:covid_app/app/global_widgets/rounded_button.dart';
import 'package:covid_app/app/modules/home/home_controller.dart';
import 'package:covid_app/app/modules/notification/notification_controller.dart';
import 'package:covid_app/app/theme/color_theme.dart';
import 'package:covid_app/app/utils/responsive.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class NotificationUI extends StatefulWidget {
  const NotificationUI({Key key}) : super(key: key);

  @override
  _NotificationUIState createState() => _NotificationUIState();
}

class _NotificationUIState extends State<NotificationUI> {
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final HomeController _homeController =
        Get.put<HomeController>(HomeController());

    return GetBuilder<NotificationController>(
      id: 'notification',
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
                    child: Header(title: 'NOTIFICACIONES'),
                  ),
                ),
                Positioned(
                  top: responsive.hp(14),
                  child: Container(
                    width: responsive.width,
                    child: Column(
                      children: [
                        (_homeController.notifications.length < 1)
                            ? Container(
                                height: responsive.hp(73),
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/screens/contact/empty.svg',
                                        height: responsive.hp(20)),
                                    SizedBox(height: responsive.hp(2)),
                                    Text('No hay notificaciones disponibles.')
                                  ],
                                ),
                              )
                            : Container(
                                height: responsive.hp(73),
                                width: double.infinity,
                                child: Scrollbar(
                                    child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: _homeController
                                            .notifications.length,
                                        itemBuilder: (context, index) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: responsive.wp(1)),
                                            child: Card(
                                              color: ColorsPalette.primary,
                                              child: ListTile(
                                                dense: true,
                                                leading: Icon(
                                                    Icons
                                                        .notification_important,
                                                    color: Colors.white),
                                                title: Text(
                                                    _homeController
                                                        .notifications[index]
                                                        .message,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                subtitle: Text(
                                                    'El día ' +
                                                        formatDate(
                                                            DateTime.fromMillisecondsSinceEpoch(_homeController
                                                                .notifications[index]
                                                                .date),
                                                            [
                                                              dd,
                                                              '-',
                                                              mm,
                                                              '-',
                                                              yyyy,
                                                              ' a las ',
                                                              hh,
                                                              ':',
                                                              mm,
                                                              ':',
                                                              ss
                                                            ]),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    )),
                                              ),
                                            ),
                                          );
                                        })),
                              ),
                        SizedBox(height: responsive.hp(2)),
                        (_homeController.notifications.length > 0) ? (_.loading) ? CircularProgressIndicator() : RoundedButton(
                            text: 'Eliminar notificaciones',
                            color: ColorsPalette.primary,
                            onPressed: () => _.deleteNotifications()) : SizedBox.shrink()
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
