import 'package:covid_app/app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'paragraph.dart';

class Slide extends StatelessWidget {
  final String svg, title, description;
  const Slide(
      {Key key,
      @required this.svg,
      @required this.title,
      @required this.description})
      : assert(svg != null && title != null && description != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return SafeArea(
      child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SvgPicture.asset(
                this.svg,
                width: responsive.dp(30),
              ),
              SizedBox(height: responsive.dp(8)),
              Text(this.title, style: TextStyle(fontSize: responsive.dp(4.5), color: Colors.black45)),
              SizedBox(height: responsive.dp(2)),
              Paragraph(text: this.description, fontSize: 2, color: Colors.black45)
            ],
          )),
    );
  }
}
