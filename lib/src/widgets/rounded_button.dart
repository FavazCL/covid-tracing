import 'package:covid_app/src/utils/responsive.dart';
import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  const RoundedButton(
      {Key key, @required this.text, @required this.color, this.onPressed})
      : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return Container(
        child: SizedBox(
      height: responsive.dp(5.5),
      width: responsive.dp(20),
      child: RaisedButton(
        color: this.color,
        child: Text(
          this.text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white,
              fontFamily: 'monse',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5),
        ),
        shape:
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(60.0)
            ),
        elevation: 1,
        onPressed: this.onPressed,
      ),
    ));
  }
}
