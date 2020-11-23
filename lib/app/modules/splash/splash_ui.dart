import 'package:covid_app/app/modules/splash/splash_controller.dart';
import 'package:covid_app/app/routes/app_routes.dart';
import 'package:covid_app/app/theme/color_theme.dart';
import 'package:covid_app/app/utils/responsive.dart';
import 'package:covid_app/app/utils/shared_preferences/shared_prefs_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:lottie/lottie.dart';

class SplashUI extends StatefulWidget {
  const SplashUI({Key key}) : super(key: key);

  @override
  _SplashUIState createState() => _SplashUIState();
}

class _SplashUIState extends State<SplashUI> with TickerProviderStateMixin {
  final SharedPrefsController sharedPrefs = Get.put(SharedPrefsController());
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);

    _controller.addListener(() {
      if (_controller.isCompleted) {
        if (sharedPrefs.intro && sharedPrefs.permissions) {
          Get.offAndToNamed(AppRoutes.HOME);
        }

        if (sharedPrefs.intro && !sharedPrefs.permissions) {
          Get.offAndToNamed(AppRoutes.PERMISSION);
        }

        if (!sharedPrefs.intro) {
          Get.offAndToNamed(AppRoutes.INTRO);
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive.of(context);

    return GetBuilder<SplashController>(
        builder: (_) => Scaffold(
              body: Container(
                color: Colors.white,
                height: responsive.height,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('COVID TRACING',
                        style: TextStyle(
                            color: ColorsPalette.primary,
                            fontSize: responsive.dp(4.5),
                            fontFamily: 'monse',
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: responsive.hp(3)),
                    Lottie.asset('assets/animations/mask.json',
                        controller: _controller, onLoaded: (composition) {
                      _controller
                        ..duration = composition.duration
                        ..forward();
                    }),
                    SizedBox(height: responsive.hp(3)),
                    Text('Bienvenido/a!',
                        style: TextStyle(
                          color: ColorsPalette.primary,
                          fontFamily: 'monse',
                          fontWeight: FontWeight.w600,
                          fontSize: responsive.dp(3),
                        ))
                  ],
                ),
              ),
            ));
  }
}
