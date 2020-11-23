import 'package:get/get.dart';

class IntroController extends GetxController {
  RxInt _page = 0.obs;

  int get page => _page.value;

  @override
  void onClose() {
    super.onClose();
  }

  void changeSlide(int value) {
    _page.value = value;
  }
}