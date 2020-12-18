import 'package:covid_app/app/theme/color_theme.dart';
import 'package:covid_app/app/utils/responsive.dart';
import 'package:flutter/material.dart';

import 'custom_tile.dart';

class Question extends StatelessWidget {
  final String title, description;
  final IconData iconData;

  const Question(
      {Key key,
      @required this.title,
      @required this.description,
      @required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Container(
        margin: EdgeInsets.symmetric(horizontal: responsive.wp(5)),
        decoration: BoxDecoration(
            color: ColorsPalette.primary, borderRadius: BorderRadius.circular(12)),
        child: CustomTile(
          title: this.title,
          description: this.description,
          iconData: this.iconData,
        ));
  }
}
