import 'package:covid_app/app/theme/color_theme.dart';
import 'package:covid_app/app/utils/responsive.dart';
import 'package:flutter/material.dart';

class CardDetail extends StatelessWidget {
  final String title;
  final IconData icon;
  const CardDetail({Key key, this.title, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Card(
      color: ColorsPalette.primary,
      child: ListTile(
        leading: Icon(this.icon, color: Colors.white),
        title: Text(this.title,
            style: TextStyle(
                fontSize: responsive.dp(1.5),
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );
  }
}
