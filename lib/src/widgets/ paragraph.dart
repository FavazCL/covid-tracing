import 'package:covid_app/src/utils/responsive.dart';
import 'package:flutter/material.dart';

class Paragraph extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  const Paragraph(
      {Key key,
      @required this.text,
      this.fontSize = 2,
      this.fontWeight = FontWeight.w400,
      this.color})
      : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: responsive.dp(2)),
      child: Text(
        this.text,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontFamily: 'monse',
            fontWeight: this.fontWeight,
            fontSize: responsive.dp(this.fontSize),
            color: this.color),
      ),
    );
  }
}
