import 'package:covid_app/src/controllers/permission_controller.dart';
import 'package:covid_app/src/screens/permission/widgets/dots.dart';
import 'package:covid_app/src/screens/permission/widgets/slides.dart';
import 'package:covid_app/src/utils/responsive.dart';
import 'package:covid_app/src/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PermissionUI extends StatelessWidget {
  const PermissionUI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Scaffold(
        body: Center(
            child: Column(
      children: [
        Expanded(child: Slides()),
        //SizedBox(height: responsive.dp(4)),
        /*
        GetBuilder<PermissionController>(
          init: PermissionController(),
          builder: (_) {
            return RoundedButton(text: 'OTORGAR PERMISO', color: null, onPressed: () {
              _.selectPermission(_.page);
            });
          },
        ),
        */
        Dots(),
      ],
    )));
  }
}
