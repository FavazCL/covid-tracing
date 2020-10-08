import 'package:covid_app/app/modules/intro/intro_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'app/modules/intro/intro_binding.dart';
import 'app/routes/app_pages.dart';
import 'app/utils/dependency_injection.dart';

void main() {
  DependencyInjection.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);

    return GetMaterialApp(
      title: 'Covid tracing',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'monse'     
      ),
      home: IntroUI(),
      initialBinding: IntroBinding(),
      getPages: AppPages.pages,
    );
  }
}

