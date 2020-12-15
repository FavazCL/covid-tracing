import 'package:covid_app/app/utils/crypto_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ScanController extends GetxController {

  static const platform = const MethodChannel('dev/tracing');
  final CryptoController _cryptoController =
      Get.put<CryptoController>(CryptoController());

  Future<void> startScan() async {
    print('ephid a compartir: ${_cryptoController.ephId.data}');
    await platform.invokeMethod('start', <String, dynamic>{
      'data': _cryptoController.ephId.data
    });
  }

  Future<void> stopScan() async {
    await platform.invokeMethod('stop');
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    print('on init');
    startScan();
  }

}