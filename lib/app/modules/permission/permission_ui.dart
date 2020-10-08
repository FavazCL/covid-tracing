import 'package:covid_app/app/modules/permission/widgets/dots.dart';
import 'package:covid_app/app/modules/permission/widgets/slides.dart';
import 'package:flutter/material.dart';

class PermissionUI extends StatelessWidget {
  const PermissionUI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(
      children: [
        Expanded(child: Slides()),
        Dots(),
      ],
    )));
  }
}
