import 'package:get/state_manager.dart';

class IntroController extends GetxController {
  RxInt _page = 0.obs;

  int get page => _page.value;

  void changeSlide(int value) {
    _page.value = value;
  }

}