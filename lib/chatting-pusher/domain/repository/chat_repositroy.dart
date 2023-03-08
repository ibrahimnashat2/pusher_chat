import 'package:dartz/dartz.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:pusher_chat/chatting-pusher/domain/entities/history.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/chat_user_model.dart';
import '../entities/chat_message.dart';
import '../entities/chat_room.dart';
import '../entities/chat_user.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<ChatMessage>>> getAllMessages({
    required String roomId,
  });

  Future<Either<Failure, List<ChatRoom>>> getAllRooms();
  Future<Either<Failure, Unit>> onListenPusher({
    required Function(PusherEvent) onEvent,
    required Function() onConnected,
  });

  Future<Either<Failure, ChatRoom>> saveRoom({
    String? lastMessage,
    String? lastUpdated,
    String? lastCustomerService,
    required String roomId,
    required ChatUser user,
  });

  Future<Either<Failure, Unit>> typing({
    required bool typing,
    required int senderId,
  });
  Future<Either<Failure, Unit>> online({
    required bool state,
    required int senderId,
    required int ownerId,
  });

  Future<Either<Failure, ChatMessage>> sendMessage({
    required dynamic message,
    required ChatUserModel sender,
    required String type,
    required String roomId,
    required String messageId,
  });
  Future<Either<Failure, Unit>> saveMessage({
    required String message,
    required ChatUserModel sender,
    required String type,
    required String roomId,
    required String messageId,
  });
  Future<Either<Failure, Unit>> deleteMessage({
    required int id,
    required int senderId,
  });

  Future<Either<Failure, List<History>>> getHistory();

  Future<Either<Failure, Unit>> saveHistory({
    required int id,
    required int userId,
    required String roomId,
  });

  Future<Either<Failure, Unit>> disconnect();
}
