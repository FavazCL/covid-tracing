import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ScanController extends GetxController {
  static const platform = const MethodChannel('dev/tracing');

  Future<void> stopScan() async {
    await platform.invokeMethod('stop');
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    // startScan();
  }

  @override
  void onClose() {
    stopScan();
    super.onClose();
  }
}
