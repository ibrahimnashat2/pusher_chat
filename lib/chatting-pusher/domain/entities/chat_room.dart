// ignore_for_file: must_be_immutable

import 'chat_user.dart';

class ChatRoom {
  String roomId;
  final ChatUser user;
  String? lastMessage;
  String? lastUpdated;

  ChatRoom({
    this.lastMessage,
    this.lastUpdated,
    required this.roomId,
    required this.user,
  });
}
