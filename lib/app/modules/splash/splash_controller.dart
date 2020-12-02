import 'package:covid_app/app/data/repositories/local/fcm_repository.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class SplashController extends GetxController {
  final FCMRepository _fcmRepository =
      Get.find<FCMRepository>();
  @override
  void onInit() {
    super.onInit();
    _fcmRepository.configure();
    _fcmRepository.fcmSubscribe();
  }

}