import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:isar/isar.dart';

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
    required int senderId,
    required String type,
    required String roomId,
    required String messageId,
  });
  Future<ChatRoomModel> saveRoom({
    String? lastMessage,
    String? lastUpdated,
    required String roomId,
    required ChatUser user,
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
    required int senderId,
    required String type,
    required String roomId,
    required String messageId,
  }) async {
    return await handler<Unit>(method: () async {
      await isaar.writeOrUpdate<ChatMessageModel>(
        object: ChatMessageModel(
          messageId: messageId,
          senderId: senderId,
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
}
