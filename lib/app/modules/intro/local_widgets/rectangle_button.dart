import 'package:covid_app/app/modules/intro/intro_controller.dart';
import 'package:covid_app/app/routes/app_routes.dart';
import 'package:covid_app/app/theme/color_theme.dart';
import 'package:covid_app/app/utils/responsive.dart';
import 'package:covid_app/app/utils/shared_preferences/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RectangleButton extends StatelessWidget {
  final String text;
  const RectangleButton({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IntroController introController = Get.find<IntroController>();
    final Responsive responsive = Responsive.of(context);
    final SharedPrefs sharedPrefs = Get.put(SharedPrefs());

    return Obx(() {
      return Container(
          width: responsive.width,
          height: responsive.dp(7),
          color: introController.page == 3
              ? ColorsPalette.primary
              : Colors.black12,
          child: FlatButton(
            child: Text(introController.page == 3 ? 'COMENZAR' : this.text,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: introController.page == 3
                        ? Colors.white
                        : ColorsPalette.primary)),
            onPressed: () =>
                introController.page == 3 ? _verifyPermissions(sharedPrefs) : null,
          ));
    });
  }

  void _verifyPermissions(SharedPrefs sharedPrefs) {
    (sharedPrefs.permissions) ? Get.toNamed(AppRoutes.HOME) : Get.toNamed(AppRoutes.PERMISSION);
  }
}
