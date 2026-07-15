import 'package:social_walking_2/models/enums/sw_chat_message_type.dart';

class SWChatMessage {
  final String senderId;
  final String text;
  final DateTime sent;
  final SWChatMessageType type;

  SWChatMessage({
    required this.senderId,
    required this.text,
    required this.sent,
    required this.type,
  });
}
