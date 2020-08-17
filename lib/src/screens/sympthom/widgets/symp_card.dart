import 'package:covid_app/src/utils/colors.dart';
import 'package:covid_app/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SympCard extends StatelessWidget {
  final String path, text;
  final double fontSize;
  final Color color;
  const SympCard(
      {Key key,
      @required this.path,
      this.text,
      this.fontSize,
      this.color = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: responsive.dp(2)),
      child: Card(
          color: ColorsPalette.primary,
          elevation: .8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            dense: true,
            enabled: false,

            leading: SvgPicture.asset(this.path, width: responsive.dp(5)),
            title: Text(this.text,
                style: TextStyle(
                    fontSize: this.fontSize,
                    color: this.color,
                    fontWeight: FontWeight.bold)),
            onTap: () {},
          )),
    );
  }
}
