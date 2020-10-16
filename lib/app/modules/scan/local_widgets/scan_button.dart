import 'package:covid_app/app/theme/color_theme.dart';
import 'package:covid_app/app/utils/responsive.dart';
import 'package:flutter/material.dart';

class ScanButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool scan;
  const ScanButton({Key key, this.onPressed, this.text, this.scan}) : super(key: key);

  @override
  _ScanButtonState createState() => _ScanButtonState();
}

class _ScanButtonState extends State<ScanButton> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> enlarge;

  @override
  void initState() {
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));

    enlarge = Tween(begin: (this.widget.scan) ? 0.9 : 0.95, end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    // if (this.widget.scan) controller.repeat(reverse: true);
    controller.repeat(reverse: true);

    return AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget widget) {
          return Transform.scale(
            scale: enlarge.value,
            child: RaisedButton(
              child: Container(
                height: responsive.dp(25),
                width: responsive.dp(25),
                alignment: Alignment.center,
                child: Text(this.widget.text,
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
                    color: ColorsPalette.dark.withOpacity(0.97)),
              ),
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(responsive.dp(50))),
              onPressed: this.widget.onPressed,
            ),
          );
        });
  }
}
