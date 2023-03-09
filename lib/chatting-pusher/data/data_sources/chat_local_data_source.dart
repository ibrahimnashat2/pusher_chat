import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';
import 'package:pusher_chat/chatting-pusher/data/models/history_model.dart';

import '../../../../core/errors/exeption_handler.dart';
import '../../../core/isar/isar.dart';
import '../../domain/entities/chat_user.dart';
import '../models/chat_message_model.dart';
import '../models/chat_room_model.dart';
import '../models/chat_user_model.dart';

abstract class ChatLocalDataSource {
  Future<List<ChatMessageModel>> getAllMessages({
    required String roomId,
  });
  Future<List<ChatRoomModel>> getAllRooms();
  Future<Unit> saveMessage({
    required String message,
    required ChatUserModel sender,
    ChatUserModel? reciever,
    required String type,
    required String roomId,
    required String messageId,
  });
  Future<ChatRoomModel> saveRoom({
    String? lastMessage,
    String? lastUpdated,
    String? lastCustomerService,
    int unReadCount = 0,
    required String roomId,
    required ChatUser user,
  });

  Future<List<HistoryModel>> getHistory();

  Future<Unit> saveHistory({
    required int id,
    required int userId,
    required String roomId,
  });
}

@LazySingleton(as: ChatLocalDataSource)
class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  final Isaar isaar;
  final ExceptionHandler handler;

  ChatLocalDataSourceImpl({
    required this.handler,
    required this.isaar,
  });

  @override
  Future<List<ChatMessageModel>> getAllMessages({
    required String roomId,
  }) async {
    return await handler<List<ChatMessageModel>>(method: () async {
      final res = await isaar.getAllWithQuery<ChatMessageModel>(
        query: (isa) {
          return isa.filter().roomIdEqualTo(roomId);
        },
      );
      return res;
    });
  }

  @override
  Future<List<ChatRoomModel>> getAllRooms() async {
    return await handler<List<ChatRoomModel>>(method: () async {
      return await isaar.getAll<ChatRoomModel>();
    });
  }

  @override
  Future<Unit> saveMessage({
    required String message,
    required ChatUserModel sender,
    ChatUserModel? reciever,
    required String type,
    required String roomId,
    required String messageId,
  }) async {
    return await handler<Unit>(method: () async {
      await isaar.writeOrUpdate<ChatMessageModel>(
        object: ChatMessageModel(
          reciever: reciever,
          messageId: messageId,
          sender: sender,
          message: message,
          roomId: roomId,
          type: type,
          createdAt: DateTime.now().toIso8601String(),
        ),
      );
      return unit;
    });
  }

  @override
  Future<ChatRoomModel> saveRoom({
    String? lastMessage,
    String? lastUpdated,
    String? lastCustomerService,
    int unReadCount = 0,
    required String roomId,
    required ChatUser user,
  }) async {
    return await handler<ChatRoomModel>(method: () async {
      final res = await isaar
          .getWhereQuery<ChatRoomModel>()
          .filter()
          .roomIdEqualTo(roomId)
          .findFirst();
      final room = ChatRoomModel(
        id: res != null ? res.id : Isar.autoIncrement,
        roomId: roomId,
        lastMessage: lastMessage,
        lastUpdated: lastUpdated,
        lastCustomerService: lastCustomerService,
        unReadCount: unReadCount,
        user: ChatUserModel(
          image: user.image,
          name: user.name,
          id: user.id,
        ),
      );
      await isaar.writeOrUpdate<ChatRoomModel>(object: room);
      return room;
    });
  }

  @override
  Future<List<HistoryModel>> getHistory() async {
    return await handler<List<HistoryModel>>(method: () async {
      return await isaar.getAll<HistoryModel>();
    });
  }

  @override
  Future<Unit> saveHistory({
    required int id,
    required int userId,
    required String roomId,
  }) async {
    return await handler<Unit>(method: () async {
      await isaar.writeOrUpdate<HistoryModel>(
        object: HistoryModel(
          userId: userId,
          roomId: roomId,
          id: id,
        ),
      );
      return unit;
    });
  }
}
