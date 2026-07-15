import 'package:social_walking_2/models/classes/sw_location.dart';

class SWCowalkPathNode {
  final SWLocation location;
  final DateTime timestamp;
  final int steps;

  SWCowalkPathNode({
    required this.location,
    required this.timestamp,
    required this.steps,
  });
}
