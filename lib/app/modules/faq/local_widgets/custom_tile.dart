import 'package:covid_app/app/theme/color_theme.dart';
import 'package:covid_app/app/utils/responsive.dart';
import 'package:flutter/material.dart';

import 'box.dart';

class CustomTile extends StatelessWidget {
  final String title, description;
  final IconData iconData;

  const CustomTile(
      {Key key,
      @required this.title,
      @required this.description,
      @required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return ExpansionTile(
      title: Text(this.title, style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: responsive.dp(1.5)
      )),
      leading: Icon(this.iconData),
      children: [Box(text: this.description, color: ColorsPalette.dark.withOpacity(0.1))],
    );
  }
}
