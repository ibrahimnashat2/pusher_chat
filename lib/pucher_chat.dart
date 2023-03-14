library pusher_chat;

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:pusher_chat/core/errors/exeption_handler.dart';
import 'package:pusher_chat/core/network_info.dart';

import 'chatting-pusher/data/data_sources/chat_local_data_source.dart';
import 'chatting-pusher/data/models/chat_message_model.dart';
import 'chatting-pusher/data/models/chat_room_model.dart';
import 'chatting-pusher/data/models/history_model.dart';
import 'chatting-pusher/domain/entities/chat_message.dart';
import 'chatting-pusher/domain/entities/chat_user.dart';
import 'core/injection/injectable.dart';
import 'core/isar/isar.dart';
import 'core/print.dart';

class PusherChat {
  static late final Isaar _isaar;
  static Future<void> init() async {
    configureDependencies();
    _isaar = getIt<Isaar>();
    await _isaar.openObject(
      schemas: [
        ChatMessageModelSchema,
        ChatRoomModelSchema,
        HistoryModelSchema,
      ],
      name: 'chatting_database',
    );
  }

  static Future<void> clear() async {
    await _isaar.clear();
  }
}

class PusherChatFCMBackground {
  late final ChatLocalDataSource localDataSource;
  bool isInitialized = false;
  Future<void> init() async {
    if (!isInitialized) {
      try {
        final isaar = IsaarImpl();
        await isaar.openObject(
          schemas: [
            ChatMessageModelSchema,
            ChatRoomModelSchema,
            HistoryModelSchema,
          ],
          name: 'chatting_database',
        );
        localDataSource = ChatLocalDataSourceImpl(
          isaar: isaar,
        );
        isInitialized = true;
      } catch (e) {
        kPrint(e);
      }
    }
  }

  Future<void> onRecieveMessage({
    required ChatMessageModel message,
    required Function onMeRepliedBeforeDo,
  }) async {
    await _saveOrUpdateRoom(message, onMeRepliedBeforeDo);
    await _saveMessage(message);
  }

  Future<void> _saveOrUpdateRoom(
    ChatMessage message,
    Function onMeRepliedBeforeDo,
  ) async {
    final rooms = await localDataSource.getAllRooms();
    final index = rooms.indexWhere((item) => item.roomId == message.roomId);
    int unReadCount = 0;
    String senderName = '';
    String lastUpdated = DateTime.now().toIso8601String();
    ChatUser user = message.sender;
    bool iAmRepliedInRoomOrNoReplay = false;
    if (index != -1) {
      ChatRoomModel room = rooms.elementAt(index);
      final history = await localDataSource.getHistory();
      final indx = history.indexWhere(
        (item) => item.roomId == message.roomId && item.userId == user.id,
      );
      iAmRepliedInRoomOrNoReplay =
          (room.lastCustomerService?.isEmpty ?? false) || indx != -1;
      kPrint('iAmRepliedInRoom $iAmRepliedInRoomOrNoReplay');

      ///[if no customer service replied]
      if (iAmRepliedInRoomOrNoReplay) {
        unReadCount++;
        unReadCount += room.unReadCount;
      } else {
        unReadCount = 0;
      }
      room.lastMessage = message.message;
      room.lastUpdated = DateTime.now().toIso8601String();
      senderName = "${room.lastCustomerService}";
      rooms[index] = room;
    }
    if (message.reciever != null) {
      user = message.reciever!;
      senderName = message.sender.name;
    }
    await localDataSource.saveRoom(
      lastMessage: message.message,
      lastUpdated: lastUpdated,
      roomId: message.roomId,
      user: user,
      lastCustomerService: senderName,
      unReadCount: unReadCount,
    );
    if (iAmRepliedInRoomOrNoReplay) {
      onMeRepliedBeforeDo();
    }
  }

  Future<void> _saveMessage(ChatMessageModel message) async {
    await localDataSource.saveMessage(
      message: message.message,
      sender: message.sender,
      messageId: message.messageId,
      type: message.type,
      roomId: message.roomId,
    );
  }
}
