// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// import 'package:go_router/go_router.dart';
// import 'package:social_walking_2/repositories/auth_repository.dart';
// import 'package:social_walking_2/ui/simple_ui.dart';
// import 'package:social_walking_2/utils/ble_broadcaster.dart';

// class HomeScreen extends ConsumerStatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   ConsumerState<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends ConsumerState<HomeScreen> {
//   final broadcaster = BLEBroadcaster();

//   void startBLEScanning() async {
//     final targetUuid = Guid(broadcaster.serviceUuid);

//     await FlutterBluePlus.adapterState
//         .where((val) => val == BluetoothAdapterState.on)
//         .first;

//     await FlutterBluePlus.startScan(
//       //withServices: [targetUuid],
//       timeout: const Duration(seconds: 15),
//     );

//     var subscription = FlutterBluePlus.scanResults.listen((results) {
//       for (ScanResult r in results) {
//         final broadcastedName = r.advertisementData.advName;
//         final serviceUuids = r.advertisementData.serviceUuids;
//         if (serviceUuids.contains(targetUuid)) {
//           print("🚨 FOUND OUR APP! UUIDs: $serviceUuids");
//         } else if (broadcastedName.isNotEmpty) {
//           print("Found other device: $broadcastedName | UUIDs: $serviceUuids");
//         }
//       }
//     }, onError: (e) => print("Error scanning: $e"));
//   }

//   void startBLEBroadcasting() {
//     broadcaster.startBroadcasting(
//       ref.read(authRepositoryProvider).getCurrentUserId(),
//     );
//   }

//   void stopBLEBroadcasting() {
//     broadcaster.stopBroadcasting();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.stretch,
//       spacing: 8.0,
//       children: [
//         customButton(text: "Start Scan", onPressed: startBLEScanning),
//         customButton(text: "Start Broadcast", onPressed: startBLEBroadcasting),
//         customButton(text: "Stop Broadcast", onPressed: stopBLEBroadcasting),
//         customButton(
//           text: "Logout",
//           onPressed: () {
//             ref.read(authRepositoryProvider).signOut();
//             context.go("/");
//           },
//         ),
//       ],
//     );
//   }
// }
