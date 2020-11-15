import 'package:get/state_manager.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';

class ScanController extends GetxController {

  // Blemulator blemulator = Blemulator();
  // BleManager bleManager = BleManager();
  BleManager bleManager2 = BleManager();

  @override
  void onClose() {
    // bleManager2?.stopPeripheralScan();
    // bleManager2.destroyClient();
    // bleManager?.destroyClient();
    stop();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    initEmulator();
  }

  stop() async {
    await bleManager2?.stopPeripheralScan();
    await bleManager2.destroyClient();
  }

  void initEmulator() async {
    // blemulator.addSimulatedPeripheral(PeripheralTracing());
    // await blemulator.simulate();
    // await bleManager.createClient();

    await bleManager2.createClient();
    bleManager2.startPeripheralScan().listen((scanResult) {
         print("Scanned Peripheral ${scanResult.peripheral.identifier}, RSSI ${scanResult.rssi}");
    }, onError: (e) {
      print('Error when start scan: $e');
    }, onDone: () {
      print('Done');
    });
  }

}