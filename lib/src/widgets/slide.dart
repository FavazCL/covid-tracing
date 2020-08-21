import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Slide extends StatelessWidget {
  final String svg;
  const Slide({Key key, @required this.svg}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.all(30),
      child: SvgPicture.asset(this.svg),
    );
  }
}