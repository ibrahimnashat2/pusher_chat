// ignore_for_file: must_be_immutable

import 'chat_user.dart';

class ChatRoom {
  String roomId;
  final ChatUser user;
  String? lastMessage;
  String? lastUpdated;
  String? lastCustomerService;
  int unReadCount;

  ChatRoom({
    this.lastCustomerService,
    this.unReadCount = 0,
    this.lastMessage,
    this.lastUpdated,
    required this.roomId,
    required this.user,
  });
}
