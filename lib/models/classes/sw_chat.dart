import 'package:social_walking_2/models/classes/sw_date_time.dart';

class SWChat {
  final SWDateTime created;
  final String receiverId;
  final String senderId;
  final int cowalksFinished;

  SWChat({
    required this.created,
    required this.receiverId,
    required this.senderId,
    required this.cowalksFinished,
  });
}
