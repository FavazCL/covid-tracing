import 'package:covid_app/app/data/models/EphId.dart';
import 'package:covid_app/app/data/models/Report.dart';
import 'package:covid_app/app/routes/app_routes.dart';
import 'package:covid_app/app/utils/crypto_controller.dart';
import 'package:covid_app/app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'navigator_item.dart';

class BottomNavigator extends StatelessWidget {
  const BottomNavigator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    final CryptoController _cryptoController =
      Get.put<CryptoController>(CryptoController());

    return Container(
      height: responsive.dp(8),
      width: double.infinity,
      color: Colors.white,
      child: Row(
        children: [
          Flexible(
              flex: 1,
              child: NavigatorItem(
                title: 'Contactos',
                path: 'assets/screens/home/notification.svg',
                onPressed: () => Get.toNamed(AppRoutes.CONTACT)
                // _cryptoController.compareEphIds(Report(ephId: _cryptoController.ephId, reportDate: DateTime.now().millisecondsSinceEpoch)),
              )),
          Flexible(
            flex: 1,
            child: NavigatorItem(
              title: 'Reportar',
              path: 'assets/screens/home/send.svg',
              onPressed: () => Get.toNamed(AppRoutes.REPORT),
            ),
          ),
          Flexible(
              flex: 1,
              child: NavigatorItem(
                title: 'Ayuda',
                path: 'assets/screens/home/faq.svg',
                onPressed: () => Get.toNamed(AppRoutes.FAQ),
              )),
        ],
      ),
    );
  }
}
