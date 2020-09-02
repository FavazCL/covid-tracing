import 'package:covid_app/src/screens/home/widgets/scan_button.dart';
import 'package:covid_app/src/utils/colors.dart';
import 'package:flutter/material.dart';

class ScanUI extends StatelessWidget {
  const ScanUI({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorsPalette.dark,
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(child: Text('title')),
              Hero(
                tag: 'scan',
                child: ScanButton(),
              ),
              Container(child: Text('button'))
            ],
          )),
    );
  }
}
