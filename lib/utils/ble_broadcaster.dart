import 'package:flutter_ble_peripheral/flutter_ble_peripheral.dart';

class BLEBroadcaster {
  final FlutterBlePeripheral blePeripheral = FlutterBlePeripheral();

  // key used to connect devices
  final String serviceUuid = "151e21bf-3688-bc3d-1867-2e5cc08b0302";

  Future<void> startBroadcasting(String uid) async {
    // check that broadcasting is supported
    final bool isSupported = await blePeripheral.isSupported;
    if (!isSupported) {
      Exception("BLE Advertising is not supported on this device.");
      return;
    }

    // configure broadcasting
    final AdvertiseData advertiseData = AdvertiseData(
      serviceUuid: serviceUuid,
      localName: uid,
    );

    // start
    try {
      await blePeripheral.start(advertiseData: advertiseData);
      print("Broadcasting as $uid...");
    } catch (e) {
      print("Failed to start broadcasting: $e");
    }
  }

  Future<void> stopBroadcasting() async {
    await blePeripheral.stop();
    print("Stopped broadcasting.");
  }
}
