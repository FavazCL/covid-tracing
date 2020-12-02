import 'package:covid_app/app/data/providers/local/fcm_api.dart';
import 'package:get/get.dart';

class FCMRepository {
  final FCMApi _api = Get.find<FCMApi>();

  void configure() => _api.configure();
  void fcmSubscribe() => _api.fcmSubscribe();
  void fcmUnSubscribe() => _api.fcmUnSubscribe();
}