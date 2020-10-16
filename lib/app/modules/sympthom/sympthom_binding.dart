import 'package:get/get.dart';
import 'sympthom_controller.dart';

class SympthomBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SympthomController>(() => SympthomController());
  }
}