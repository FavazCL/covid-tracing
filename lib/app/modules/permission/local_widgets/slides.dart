import 'package:covid_app/app/global_widgets/rounded_button.dart';
import 'package:covid_app/app/global_widgets/slide.dart';
import 'package:covid_app/app/theme/color_theme.dart';
import 'package:covid_app/app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import '../permission_controller.dart';

class Slides extends StatelessWidget {
  const Slides({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return GetBuilder<PermissionController>(
      id: 'permission',
      builder: (_) {
        return Container(
            child: PageView(
          onPageChanged: (int value) {
            _.changeSlide(value);
          },
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Slide(
                    svg: 'assets/screens/permission/current_location.svg',
                    title: 'LOCALIZACIÓN',
                    description:
                        'Es necesario para aumentar la precisión en la busqueda de dispositivos, No será necesario activarlo para el uso de la app.'),
                SizedBox(height: responsive.dp(4)),
                RoundedButton(
                    text: (_.location) ? 'OTORGADO' : 'OTORGAR PERMISO',
                    color: (_.location)
                        ? Colors.greenAccent
                        : ColorsPalette.primary,
                    onPressed: () async =>
                        (_.location) ? null : await _.selectPermission(_.page))
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Slide(
                    svg: 'assets/screens/permission/push_notification.svg',
                    title: 'NOTIFICACIÓN',
                    description:
                        'Es necesario para notificar cuando exista un posible contacto estrecho.'),
                SizedBox(height: responsive.dp(4)),
                RoundedButton(
                    text: (_.notification) ? 'OTORGADO' : 'OTORGAR PERMISO',
                    color: (_.notification)
                        ? Colors.greenAccent
                        : ColorsPalette.primary,
                    onPressed: () async =>
                        (_.notification) ? null : await _.selectPermission(_.page))
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Slide(
                  svg: 'assets/screens/permission/time_management.svg',
                  title: 'BATERÍA',
                  description:
                      'Es necesario para reducir el consumo de bateria por parte de la app.',
                ),
                SizedBox(height: responsive.dp(4)),
                RoundedButton(
                    text: (_.batery) ? 'OTORGADO' : 'OTORGAR PERMISO',
                    color: (_.batery)
                        ? Colors.greenAccent
                        : ColorsPalette.primary,
                    onPressed: () async =>
                        (_.batery) ? null : await _.selectPermission(_.page))
              ],
            ),
          ],
        ));
      },
    );
  }
}
