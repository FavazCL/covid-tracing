import 'package:covid_app/src/utils/colors.dart';
import 'package:covid_app/src/utils/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;
  const Header({Key key, @required this.title})
      : assert(title != null && title.length > 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Container(
      height: responsive.hp(8),
      width: responsive.width,
      color: Colors.white,
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(this.title,
                style: TextStyle(
                    color: ColorsPalette.primary,
                    fontFamily: 'monse',
                    fontSize: responsive.dp(3.5),
                    fontWeight: FontWeight.w600)),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              color: ColorsPalette.primary,
              iconSize: responsive.dp(3.5),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
