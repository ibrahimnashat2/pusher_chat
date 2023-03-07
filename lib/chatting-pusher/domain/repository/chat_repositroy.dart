import 'package:dartz/dartz.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../../../core/errors/failures.dart';
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
  });
  Future<Either<Failure, ChatMessage>> sendMessage({
    required dynamic message,
    required int senderId,
    required String type,
    required String roomId,
    required String messageId,
  });
  Future<Either<Failure, Unit>> saveMessage({
    required String message,
    required int senderId,
    required String type,
    required String roomId,
    required String messageId,
  });
  Future<Either<Failure, Unit>> deleteMessage({
    required int id,
    required int senderId,
  });
  Future<Either<Failure, Unit>> disconnect();
}
