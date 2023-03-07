// ignore_for_file: must_be_immutable

class ChatMessage {
  String message;
  final int senderId;
  final String type;
  final String messageId;
  final String roomId;
  final String? createdAt;
  final int id;

  ChatMessage({
    required this.message,
    required this.messageId,
    required this.senderId,
    required this.type,
    required this.roomId,
    this.createdAt,
    required this.id,
  });
}
