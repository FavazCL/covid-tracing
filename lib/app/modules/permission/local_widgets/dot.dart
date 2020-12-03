import 'package:covid_app/app/modules/permission/permission_controller.dart';
import 'package:covid_app/app/theme/color_theme.dart';
import 'package:covid_app/app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dot extends StatelessWidget {
  final int position;
  final dynamic controller;
  const Dot({Key key, @required this.position, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PermissionController permissionController =
        Get.find<PermissionController>();
    final Responsive responsive = Responsive.of(context);

    return Obx(() {
      return AnimatedContainer(
        duration: Duration(milliseconds: 100),
        curve: Curves.linear,
        width: this.position == permissionController.page ? 20 : responsive.dp(1.3),
        height: responsive.dp(1.3),
        margin: EdgeInsets.symmetric(horizontal: responsive.dp(0.5)),
        decoration: BoxDecoration(
            color: this.position == permissionController.page
                ? ColorsPalette.primary
                : Colors.grey,
                borderRadius: BorderRadius.circular(12),
            shape: BoxShape.rectangle),
      );
    });
  }

}
