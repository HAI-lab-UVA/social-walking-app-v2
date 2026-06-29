import 'package:social_walking_2/models/classes/sw_date_time.dart';

class SWActionLog {
  final String action;
  final String screen;
  final SWDateTime timestamp;

  SWActionLog({
    required this.action,
    required this.screen,
    required this.timestamp,
  });
}
