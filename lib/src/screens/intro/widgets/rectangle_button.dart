import 'package:covid_app/src/controllers/intro_controller.dart';
import 'package:covid_app/src/screens/home/home_ui.dart';
import 'package:covid_app/src/utils/colors.dart';
import 'package:covid_app/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RectangleButton extends StatelessWidget {
  final String text;
  const RectangleButton({Key key, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IntroController introController =
        Get.find<IntroController>();
    final Responsive responsive = Responsive.of(context);

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
                introController.page == 3 ? Get.to(HomeUI()) : null,
          ));
    });
  }
}
