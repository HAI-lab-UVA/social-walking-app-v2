import 'package:social_walking_2/models/classes/sw_cowalk_path_node.dart';

class SWCowalkUserLog {
  final List<SWCowalkPathNode> path;
  final DateTime timestamp;

  SWCowalkUserLog({required this.path, required this.timestamp});
}
