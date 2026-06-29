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
}
