import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:pusher_chat/chatting-pusher/domain/entities/history.dart';

import '../../../../core/errors/failure_handler.dart';
import '../../../../core/errors/failures.dart';
import '../../../core/print.dart';
import '../../domain/entities/chat_message.dart';
import '../../domain/entities/chat_room.dart';
import '../../domain/entities/chat_user.dart';
import '../../domain/repository/chat_repositroy.dart';
import '../data_sources/chat_local_data_source.dart';
import '../data_sources/chat_remote_data_source.dart';
import '../models/chat_user_model.dart';

@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;
  final ChatLocalDataSource localDataSource;
  final FailureHandler handler;

  const ChatRepositoryImpl({
    required this.handler,
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<ChatMessage>>> getAllMessages({
    required String roomId,
  }) async {
    return await handler<List<ChatMessage>>(method: () async {
      return await localDataSource.getAllMessages(roomId: roomId);
    });
  }

  @override
  Future<Either<Failure, List<ChatRoom>>> getAllRooms() async {
    return await handler<List<ChatRoom>>(method: () async {
      return await localDataSource.getAllRooms();
    });
  }

  @override
  Future<Either<Failure, ChatMessage>> sendMessage({
    required dynamic message,
    required ChatUserModel sender,
    ChatUserModel? reciever,
    required String type,
    required String roomId,
    required String messageId,
  }) async {
    return await handler<ChatMessage>(method: () async {
      await saveMessage(
          message: message,
          sender: sender,
          type: type,
          roomId: roomId,
          messageId: messageId,
          reciever: reciever);
      final res = await remoteDataSource.sendMessage(
        message: message,
        sender: sender,
        type: type,
        reciever: reciever,
        roomId: roomId,
        messageId: messageId,
      );
      return res;
    });
  }

  @override
  Future<Either<Failure, Unit>> typing({
    required bool typing,
    required int senderId,
    required String roomId,
  }) async {
    return await handler<Unit>(method: () async {
      return await remoteDataSource.typing(
        typing: typing,
        senderId: senderId,
        roomId: roomId,
      );
    });
  }

  @override
  Future<Either<Failure, ChatRoom>> saveRoom({
    String? lastMessage,
    String? lastUpdated,
    String? lastCustomerService,
    int unReadCount = 0,
    required String roomId,
    required ChatUser user,
  }) async {
    return await handler<ChatRoom>(method: () async {
      return await localDataSource.saveRoom(
        lastMessage: lastMessage,
        lastUpdated: lastUpdated,
        roomId: roomId,
        user: user,
        unReadCount: unReadCount,
        lastCustomerService: lastCustomerService,
      );
    });
  }

  @override
  Future<Either<Failure, Unit>> onListenPusher({
    required Function(PusherEvent) onEvent,
    required Function() onConnected,
    required Function() onDisconnecting,
    required Function() onDisconnected,
  }) async {
    return await handler<Unit>(method: () async {
      return await remoteDataSource.onListenPusher(
        onEvent: onEvent,
        onDisconnected: onDisconnected,
        onDisconnecting: onDisconnecting,
        onConnected: onConnected,
      );
    });
  }

  @override
  Future<Either<Failure, Unit>> disconnect() async {
    return await handler<Unit>(method: () async {
      return await remoteDataSource.disconnect();
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteMessage({
    required int id,
    required int senderId,
  }) async {
    return await handler<Unit>(method: () async {
      return await remoteDataSource.deleteMessage(id: id, senderId: senderId);
    });
  }

  @override
  Future<Either<Failure, Unit>> saveMessage({
    required String message,
    required ChatUserModel sender,
    ChatUserModel? reciever,
    required String type,
    required String roomId,
    required String messageId,
  }) async {
    return await handler<Unit>(method: () async {
      kPrint('localDataSource');
      await localDataSource.saveMessage(
        message: message,
        sender: sender,
        type: type,
        roomId: roomId,
        reciever: reciever,
        messageId: messageId,
      );
      return unit;
    });
  }

  @override
  Future<Either<Failure, Unit>> online({
    required bool state,
    required int senderId,
    required int ownerId,
    required String roomId,
  }) async {
    return await handler<Unit>(method: () async {
      return await remoteDataSource.online(
        state: state,
        ownerId: ownerId,
        senderId: senderId,
        roomId: roomId,
      );
    });
  }

  @override
  Future<Either<Failure, List<History>>> getHistory() async {
    return await handler<List<History>>(method: () async {
      return await localDataSource.getHistory();
    });
  }

  @override
  Future<Either<Failure, Unit>> saveHistory({
    required int id,
    required int userId,
    required String roomId,
  }) async {
    return await handler<Unit>(method: () async {
      return await localDataSource.saveHistory(
        id: id,
        userId: userId,
        roomId: roomId,
      );
    });
  }
}
