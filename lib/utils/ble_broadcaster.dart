import 'package:flutter/services.dart';
import 'package:flutter_ble_peripheral/flutter_ble_peripheral.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class BLEBroadcaster {
  final FlutterBlePeripheral blePeripheral = FlutterBlePeripheral();

  // key used to connect devices
  final String serviceUuid = "151e21bf-3688-bc3d-1867-2e5cc08b0302";

  Future<void> startBroadcasting(String uid) async {
    // check that broadcasting is supported
    final bool isSupported = await blePeripheral.isSupported;
    if (!isSupported) {
      Exception("BLE Advertising is not supported on this device.");
      print("BLE Advertising not supported");
      return;
    }

    await FlutterBluePlus.adapterState
        .where((val) => val == BluetoothAdapterState.on)
        .first;

    await Permission.bluetoothAdvertise.request();
    await Permission.bluetoothConnect.request();

    // configure broadcasting
    final shortUid = uid.substring(0, 8);
    final AdvertiseData advertiseData = AdvertiseData(
      serviceUuid: serviceUuid,
      includeDeviceName: false,
      //localName: shortUid,
    );

    final AdvertiseSettings advertiseSettings = AdvertiseSettings(
      advertiseMode: AdvertiseMode.advertiseModeBalanced,
      txPowerLevel: AdvertiseTxPower.advertiseTxPowerMedium,
      connectable: true,
      timeout: 0, // 0 means no timeout
    );

    try {
      // Pass the settings to the start method
      await blePeripheral.start(
        advertiseData: advertiseData,
        advertiseSettings: advertiseSettings,
      );
      print("Broadcasting as $shortUid...");
    } catch (e) {
      print("Failed to start broadcasting: $e");
    }
  }

  Future<void> stopBroadcasting() async {
    await blePeripheral.stop();
    print("Stopped broadcasting.");
  }
}
