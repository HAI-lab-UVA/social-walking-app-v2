import 'package:social_walking_2/models/classes/sw_cowalk_path_node.dart';
import 'package:social_walking_2/models/classes/sw_date_time.dart';

class SWCowalkUserLog {
  final List<SWCowalkPathNode> path;
  final SWDateTime timestamp;

  SWCowalkUserLog({required this.path, required this.timestamp});
}
