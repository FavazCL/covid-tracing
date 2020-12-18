import 'package:covid_app/app/data/providers/local/db_api.dart';
import 'package:covid_app/app/data/providers/local/fcm_api.dart';
import 'package:covid_app/app/data/providers/remote/codes_api.dart';
import 'package:covid_app/app/data/providers/remote/contact_api.dart';
import 'package:covid_app/app/data/providers/remote/report_api.dart';
import 'package:covid_app/app/data/repositories/local/db_repository.dart';
import 'package:covid_app/app/data/repositories/local/fcm_repository.dart';
import 'package:covid_app/app/data/repositories/remote/codes_repository.dart';
import 'package:covid_app/app/data/repositories/remote/contact_repository.dart';
import 'package:covid_app/app/data/repositories/remote/report_repository.dart';
import 'package:covid_app/app/utils/crypto_controller.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class DependencyInjection {
  static void init() {
    Get.put<CryptoController>(CryptoController());
    Get.put<FirebaseMessaging>(FirebaseMessaging());
    Get.put<Dio>(Dio(BaseOptions(
      baseUrl: "https://us-central1-covidcl.cloudfunctions.net/",
    )));

    // Providers
    Get.put<CodesAPI>(CodesAPI());
    Get.put<ContactAPI>(ContactAPI());
    Get.put<DBAPI>(DBAPI.db);
    Get.put<FCMApi>(FCMApi());
    Get.put<ReportAPI>(ReportAPI());

    // Repositories
    Get.put<CodesRepository>(CodesRepository());
    Get.put<ContactRepository>(ContactRepository());
    Get.put<DBRepository>(DBRepository());
    Get.put<FCMRepository>(FCMRepository());
    Get.put<ReportRepository>(ReportRepository());
  }
}
