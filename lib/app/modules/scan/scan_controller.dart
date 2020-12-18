import 'package:covid_app/app/utils/crypto_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ScanController extends GetxController {
  static const platform = const MethodChannel('dev/tracing');
  final CryptoController _cryptoController =
      Get.put<CryptoController>(CryptoController());

  Future<void> startScan() async {
    print('ephid a compartir: ${_cryptoController.ephId.data}');
    var res = await platform.invokeMethod(
        'start', <String, dynamic>{'data': _cryptoController.ephId.data});

    if (res != null) {
      Get.snackbar('¡Trabajando!', '',
          snackPosition: SnackPosition.TOP,
          messageText: Text(
              'Ya puedes MINIMIZAR la aplicación y seguir con tu vida, recuerda detener la emisión cuando estes en un lugar seguro.',
              style: TextStyle(color: Colors.white)),
          colorText: Colors.white,
          duration: Duration(seconds: 5),
          icon: Icon(Icons.check, color: Colors.greenAccent));
    }
  }

  Future<void> stopScan() async {
    await platform.invokeMethod('stop');
    Get.back();
  }

  @override
  void onInit() {
    super.onInit();
    startScan();
  }

  @override
  void onClose() {
    stopScan();
    super.onClose();
  }
}
