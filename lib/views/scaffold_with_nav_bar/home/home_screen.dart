import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:go_router/go_router.dart';
import 'package:social_walking_2/repositories/auth_repository.dart';
import 'package:social_walking_2/ui/simple_ui.dart';
import 'package:social_walking_2/utils/ble_broadcaster.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

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
    broadcaster.startBroadcasting(
      ref.read(authRepositoryProvider).getCurrentUserId(),
    );
  }

  void stopBLEBroadcasting() {
    broadcaster.stopBroadcasting();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8.0,
      children: [
        customButton(text: "Start Scan", onPressed: startBLEScanning),
        customButton(text: "Start Broadcast", onPressed: startBLEBroadcasting),
        customButton(text: "Stop Broadcast", onPressed: stopBLEBroadcasting),
        customButton(
          text: "Logout",
          onPressed: () {
            ref.read(authRepositoryProvider).signOut();
            context.go("/");
          },
        ),
      ],
    );
  }
}
