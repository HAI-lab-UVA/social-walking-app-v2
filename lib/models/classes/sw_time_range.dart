import 'package:social_walking_2/models/classes/sw_time.dart';

class SWTimeRange {
  final SWTime start;
  final SWTime stop;
  final int interval;

  SWTimeRange({
    required this.start,
    required this.stop,
    required this.interval,
  });

  @override
  String toString() {
    return "$start-$stop-$interval";
  }

  List<SWTime> getTimes() {
    SWTime currentTime = start;
    List<SWTime> times = [currentTime];
    while (!currentTime.equals(stop)) {
      currentTime = currentTime.addMinutes(interval);
      times.add(currentTime);
    }
    return times;
  }

  factory SWTimeRange.fromString(String str) {
    final split = str.split("-");
    final start = SWTime.fromUTCString(split[0]);
    final stop = SWTime.fromUTCString(split[1]);
    final interval = int.parse(split[2]);
    return SWTimeRange(start: start, stop: stop, interval: interval);
  }
}
