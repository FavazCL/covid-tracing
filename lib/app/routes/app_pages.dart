import 'package:covid_app/app/modules/faq/faq_binding.dart';
import 'package:covid_app/app/modules/faq/faq_ui.dart';
import 'package:covid_app/app/modules/home/home_binding.dart';
import 'package:covid_app/app/modules/home/home_ui.dart';
import 'package:covid_app/app/modules/intro/intro_binding.dart';
import 'package:covid_app/app/modules/intro/intro_ui.dart';
import 'package:covid_app/app/modules/permission/permission_binding.dart';
import 'package:covid_app/app/modules/permission/permission_ui.dart';
import 'package:covid_app/app/modules/report/report_binding.dart';
import 'package:covid_app/app/modules/report/report_ui.dart';
import 'package:covid_app/app/modules/request/request_binding.dart';
import 'package:covid_app/app/modules/request/request_ui.dart';
import 'package:covid_app/app/modules/scan/scan_binding.dart';
import 'package:covid_app/app/modules/scan/scan_ui.dart';
import 'package:covid_app/app/modules/splash/splash_binding.dart';
import 'package:covid_app/app/modules/splash/splash_ui.dart';
import 'package:covid_app/app/modules/sympthom/sympthom_binding.dart';
import 'package:covid_app/app/modules/sympthom/sympthom_ui.dart';
import 'package:get/get.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.INTRO,
      page: () => IntroUI(),
      binding: IntroBinding()
    ),
    GetPage(
      name: AppRoutes.PERMISSION,
      page: () => PermissionUI(),
      binding: PermissionBinding()
    ),
    GetPage(
      name: AppRoutes.SYSMPTHOM,
      page: () => SympthomUI(),
      binding: SympthomBinding()
    ),
    GetPage(
      name: AppRoutes.REQUEST,
      page: () => RequestUI(),
      binding: RequestBinding()
    ),
    GetPage(
      name: AppRoutes.REPORT,
      page: () => ReportUI(),
      binding: ReportBinding()
    ),
    GetPage(
      name: AppRoutes.FAQ,
      page: () => FaqUI(),
      binding: FaqBinding()
    ),
    GetPage(
      name: AppRoutes.SCAN,
      page: () => ScanUI(),
      binding: ScanBinding()
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomeUI(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashUI(),
      binding: SplashBinding()
    )
  ];
}