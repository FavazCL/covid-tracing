import 'package:covid_app/src/screens/home/home_ui.dart';
import 'package:covid_app/src/screens/report/report_ui.dart';
import 'package:covid_app/src/screens/request/request_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'monse'     
      ),
      home: RequestUI(),
      routes: {
        HomeUI.routeName: (_) => HomeUI(),
        ReportUI.routeName: (_) => ReportUI(),
        RequestUI.routeName: (_) => RequestUI()
      },
    );
  }
}

