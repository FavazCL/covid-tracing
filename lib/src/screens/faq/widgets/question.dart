import 'package:covid_app/src/screens/faq/widgets/custom_tile.dart';
import 'package:covid_app/src/utils/colors.dart';
import 'package:flutter/material.dart';

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
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: ColorsPalette.primary, borderRadius: BorderRadius.circular(12)),
        child: CustomTile(
          title: this.title,
          description: this.description,
          iconData: this.iconData,
        ));
  }
}
