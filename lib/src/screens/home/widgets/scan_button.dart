import 'package:covid_app/src/utils/colors.dart';
import 'package:covid_app/src/utils/responsive.dart';
import 'package:flutter/material.dart';

class ScanButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const ScanButton({Key key, this.onPressed, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return RaisedButton(
      child: Container(
        height: responsive.dp(25),
        width: responsive.dp(25),
        alignment: Alignment.center,
        child: Text(this.text,
        textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: responsive.dp(2),
                color: Colors.white)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(responsive.dp(50)),
          boxShadow: [
            BoxShadow(
              color: ColorsPalette.primary.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 4,
            )
          ],
          color: ColorsPalette.dark.withOpacity(0.97)
        ),
      ),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(responsive.dp(50))),
      onPressed: this.onPressed,
    );
  }
}
