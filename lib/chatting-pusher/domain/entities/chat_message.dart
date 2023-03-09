// ignore_for_file: must_be_immutable

import 'chat_user.dart';

class ChatMessage {
  String message;
  final ChatUser sender;
  final ChatUser? reciever;
  final String type;
  final String messageId;
  final String roomId;
  final String? createdAt;
  final int id;

  ChatMessage({
    required this.message,
    required this.messageId,
    required this.sender,
    required this.type,
    required this.roomId,
    this.createdAt,
    this.reciever,
    required this.id,
  });
}
