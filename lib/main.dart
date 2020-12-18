import 'package:covid_app/app/modules/splash/splash_binding.dart';
import 'package:covid_app/app/modules/splash/splash_ui.dart';
import 'package:covid_app/app/utils/shared_preferences/shared_prefs_controller.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'app/utils/dependency_injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new SharedPrefsController();
  await prefs.loadPreferences();
  await Firebase.initializeApp();
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'monse'     
      ),
      home: SplashUI(),
      initialBinding: SplashBinding(),
      getPages: AppPages.pages,
    );
  }
}

