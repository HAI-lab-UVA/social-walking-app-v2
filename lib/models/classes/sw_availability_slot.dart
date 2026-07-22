import 'package:social_walking_2/models/classes/sw_time.dart';

class SWAvailabilitySlot {
  final SWTime time;
  late Map<int, bool> availability;

  SWAvailabilitySlot({required this.time, Map<int, bool>? availability}) {
    this.availability =
        availability ??
        {
          0: false,
          1: false,
          2: false,
          3: false,
          4: false,
          5: false,
          6: false,
          7: false,
        };
  }

  factory SWAvailabilitySlot.fromJson(Map<String, dynamic> json) {
    return SWAvailabilitySlot(
      time: SWTime.fromUTCString(json["time"]),
      availability: (json["availability"] as Map<String, dynamic>).map(
        (k, v) => MapEntry(int.parse(k), v as bool),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "time": time.toUTCString(),
      "availability": availability.map((k, v) => MapEntry(k.toString(), v)),
    };
  }
}
