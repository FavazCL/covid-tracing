import 'package:covid_app/src/utils/responsive.dart';
import 'package:covid_app/src/widgets/paragraph.dart';
import 'package:flutter/material.dart';

class Box extends StatelessWidget {
  final String text;
  final Color color;

  const Box({Key key, @required this.text, @required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: this.color,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12))),
      width: responsive.width,
      height: responsive.dp(8),
      child: Paragraph(text: this.text, fontSize: responsive.dp(0.18)),
    );
  }
}