import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:social_walking_2/ui/simple_ui.dart';
import 'package:social_walking_2/utils/ble_broadcaster.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final String uid;
  const HomeScreen({required this.uid, super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final broadcaster = BLEBroadcaster();

  void startBLEScanning() async {
    final serviceUuid = Guid(broadcaster.serviceUuid);
    await FlutterBluePlus.startScan(
      withServices: [serviceUuid],
      timeout: Duration(seconds: 15),
    );

    // listen to scan results
    var subscription = FlutterBluePlus.scanResults.listen((results) {
      for (ScanResult r in results) {
        // 1. Read the name broadcasted by the other phone
        String broadcastedName = r.advertisementData.advName;

        // 2. Read the Service UUIDs (to double-check it's your app)
        List<Guid> serviceUuids = r.advertisementData.serviceUuids;

        if (broadcastedName.isNotEmpty && serviceUuids.contains(serviceUuid)) {
          print("found: $broadcastedName");
        } else {
          print(
            "broadcastName.isNotEmpty: ${broadcastedName.isNotEmpty} and serviceUuids ${serviceUuids}",
          );
        }
      }
    }, onError: (e) => print("Error scanning: $e"));
  }

  void startBLEBroadcasting() {
    broadcaster.startBroadcasting(widget.uid);
  }

  void stopBLEBroadcasting() {
    broadcaster.stopBroadcasting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 8.0,
            children: [
              customButton(text: "Start Scan", onPressed: startBLEScanning),
              customButton(
                text: "Start Broadcast",
                onPressed: startBLEBroadcasting,
              ),
              customButton(
                text: "Stop Broadcast",
                onPressed: stopBLEBroadcasting,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
