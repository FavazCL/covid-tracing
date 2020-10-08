import 'package:covid_app/app/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageHeader extends StatelessWidget {
  final String path;
  final double size;
  const ImageHeader({Key key, @required this.path, this.size = 25})
      : assert(path != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Container(
      child: SvgPicture.asset(
        this.path,
        width: responsive.dp(size),
      ),
    );
  }
}
