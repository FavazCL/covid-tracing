import 'package:covid_app/src/utils/colors.dart';
import 'package:covid_app/src/utils/responsive.dart';
import 'package:flutter/material.dart';

class ScanButton extends StatelessWidget {
  final VoidCallback onPressed;
  const ScanButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return RaisedButton(
      child: Container(
        height: responsive.dp(25),
        width: responsive.dp(25),
        alignment: Alignment.center,
        child: Text('ESCANEAR',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: responsive.dp(2),
                color: Colors.white)),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(responsive.dp(50)),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 3,
              )
            ],
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  ColorsPalette.dark,
                  ColorsPalette.background,
                ])),
      ),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(responsive.dp(50))),
      onPressed: this.onPressed,
    );
  }
}
