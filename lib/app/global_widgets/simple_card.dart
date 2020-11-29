import 'package:covid_app/app/utils/responsive.dart';
import 'package:flutter/material.dart';

class SimpleCard extends StatelessWidget {
  final Color colorCard, colorIcon, colorTitle, colorSubtitle;
  final String title, subtitle;
  final IconData trailing;
  final bool overflow;
  const SimpleCard(
      {Key key,
      this.colorCard,
      this.colorIcon,
      @required this.title,
      this.subtitle = '',
      this.trailing, this.colorTitle, this.colorSubtitle, this.overflow = false})
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
          overflow: (overflow) ? TextOverflow.ellipsis : TextOverflow.visible,
            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monse', color: colorTitle),
          ),
          subtitle: Text(this.subtitle,
            style: TextStyle(fontFamily: 'monse', fontWeight: FontWeight.w600, color: colorSubtitle),
          ),
          trailing: Icon(this.trailing,
            color: colorIcon,
          ),
        ),
      ),
    );
  }
}
