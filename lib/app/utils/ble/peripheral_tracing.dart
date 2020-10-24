import 'dart:typed_data';

import 'package:blemulator/blemulator.dart';

class PeripheralTracing extends SimulatedPeripheral {
  PeripheralTracing(
      {String id = "4C:99:4C:34:DE:76",
      String name = "Peripheral",
      String localName = "Peripheral"})
      : super(
            name: name,
            id: id,
            advertisementInterval: Duration(milliseconds: 800),
            services: [
              SimulatedService(
                  uuid: "F000AA00-0451-4000-B000-000000000000",
                  isAdvertised: true,
                  characteristics: [
                    SimulatedCharacteristic(
                        uuid: "F000AA01-0451-4000-B000-000000000000",
                        value: Uint8List.fromList([101, 254, 64, 12]),
                        convenienceName: "IR Temperature Data"),
                    SimulatedCharacteristic(
                        uuid: "F000AA02-0451-4000-B000-000000000000",
                        value: Uint8List.fromList([0]),
                        convenienceName: "IR Temperature Config"),
                    SimulatedCharacteristic(
                        uuid: "F000AA03-0451-4000-B000-000000000000",
                        value: Uint8List.fromList([50]),
                        convenienceName: "IR Temperature Period"),
                  ],
                  convenienceName: "Temperature service")
            ]) {
              
    scanInfo = ScanInfo();
  }

  @override
  Future<bool> onConnectRequest() async {
    await Future.delayed(Duration(milliseconds: 200));
    return super.onConnectRequest();
  }
}
