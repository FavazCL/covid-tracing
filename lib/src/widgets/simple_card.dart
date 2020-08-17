import 'package:covid_app/src/utils/responsive.dart';
import 'package:flutter/material.dart';

class SimpleCard extends StatelessWidget {
  final Color colorCard, colorIcon;
  final String title, subtitle;
  final IconData trailing;
  const SimpleCard(
      {Key key,
      this.colorCard,
      this.colorIcon,
      @required this.title,
      this.subtitle = '',
      this.trailing})
      : assert(title != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: responsive.dp(2)),
      child: Card(
        color: this.colorCard,
        child: ListTile(
          dense: true,
          visualDensity: VisualDensity.comfortable,
          title: Text(this.title,
            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monse'),
          ),
          subtitle: Text(this.subtitle,
            style: TextStyle(fontFamily: 'monse', fontWeight: FontWeight.w600),
          ),
          trailing: Icon(this.trailing,
            color: colorIcon,
          ),
        ),
      ),
    );
  }
}
