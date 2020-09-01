import 'package:covid_app/src/utils/colors.dart';
import 'package:covid_app/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavigatorItem extends StatelessWidget {
  final String title, path;
  final VoidCallback onPressed;

  const NavigatorItem(
      {Key key, @required this.title, @required this.path, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return FlatButton(
      padding: EdgeInsets.zero,
      onPressed: this.onPressed,
      splashColor: ColorsPalette.primary,
      child: Container(
          width: double.infinity,
          color: Colors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(this.path, width: responsive.dp(4)),
              Text(this.title, style: TextStyle(fontWeight: FontWeight.w600))
            ],
          )),
    );
  }
}
