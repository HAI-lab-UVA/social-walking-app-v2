import 'package:social_walking_2/models/classes/sw_date_time.dart';
import 'package:social_walking_2/models/enums/sw_chat_message_type.dart';

class SWChatMessage {
  final String senderId;
  final String text;
  final SWDateTime sent;
  final SWChatMessageType type;

  SWChatMessage({
    required this.senderId,
    required this.text,
    required this.sent,
    required this.type,
  });
}
