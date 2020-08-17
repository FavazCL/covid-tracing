import 'package:covid_app/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CircleButton extends StatelessWidget {
  final String path;
  final double sizeImage, height, width;
  final Color color;
  const CircleButton(
      {Key key,
      @required this.path,
      @required this.sizeImage,
      this.height = 8.5,
      this.width = 8.5, @required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Container(
      child: SizedBox(
        height: responsive.dp(this.height),
        width: responsive.dp(this.width),
        child: RaisedButton(
          color: this.color,
          child: SvgPicture.asset(this.path,
          height: responsive.dp(this.sizeImage)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(90.0)
          ),
          elevation: 1,
          onPressed: () {}
        )
      ),
    );
  }
}
