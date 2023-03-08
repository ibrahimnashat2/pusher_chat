import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../../../core/errors/exeption_handler.dart';
import '../../../../core/pusher/pusher_channels.dart';
import '../models/chat_message_model.dart';
import '../models/chat_user_model.dart';

abstract class ChatRemoteDataSource {
  Future<Unit> typing({
    required bool typing,
    required int senderId,
  });

  Future<Unit> online({
    required bool state,
    required int senderId,
  });

  Future<ChatMessageModel> sendMessage({
    required dynamic message,
    required ChatUserModel sender,
    required String type,
    required String roomId,
    required String messageId,
  });

  Future<Unit> deleteMessage({
    required int id,
    required int senderId,
  });

  Future<Unit> disconnect();

  Future<Unit> onListenPusher({
    required Function(PusherEvent) onEvent,
    required Function() onConnected,
  });
}

@LazySingleton(as: ChatRemoteDataSource)
class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final PusherChannels pusherChannels;
  final ExceptionHandler handler;

  ChatRemoteDataSourceImpl({
    required this.pusherChannels,
    required this.handler,
  });

  @override
  Future<ChatMessageModel> sendMessage({
    required dynamic message,
    required ChatUserModel sender,
    required String type,
    required String roomId,
    required String messageId,
  }) async {
    return await handler<ChatMessageModel>(method: () async {
      final res = ChatMessageModel.fromJson({
        'message': message,
        'sender': sender.toJson(),
        'type': type,
        'roomId': roomId,
        'messageId': messageId,
        'createdAt': DateTime.now().toIso8601String(),
      });
      pusherChannels.trigger(
        channel: 'private-chat-room',
        event: 'client-add-message',
        data: res.toJson(),
      );
      return res;
    });
  }

  @override
  Future<Unit> typing({
    required bool typing,
    required int senderId,
  }) async {
    return await handler<Unit>(method: () async {
      pusherChannels.trigger(
        channel: 'private-chat-room',
        event: 'client-typing',
        data: {
          'typing': typing,
          'senderId': senderId,
        },
      );
      return unit;
    });
  }

  @override
  Future<Unit> onListenPusher({
    required Function(PusherEvent) onEvent,
    required Function() onConnected,
  }) async {
    return await handler<Unit>(method: () async {
      await pusherChannels.init(
        onEvent: onEvent,
        onConnected: onConnected,
      );
      pusherChannels.subscribe(
        channel: 'private-chat-room',
      );
      return unit;
    });
  }

  @override
  Future<Unit> disconnect() async {
    return await handler<Unit>(method: () async {
      await pusherChannels.unsubscribe(channel: 'private-chat-room');
      await pusherChannels.disconnect();
      return unit;
    });
  }

  @override
  Future<Unit> deleteMessage({
    required int id,
    required int senderId,
  }) async {
    return await handler<Unit>(method: () async {
      pusherChannels.trigger(
        channel: 'private-chat-room',
        event: 'client-delete-message',
        data: {
          'messageId': id,
          'senderId': senderId,
        },
      );
      return unit;
    });
  }

  @override
  Future<Unit> online({
    required bool state,
    required int senderId,
  }) async {
    return await handler<Unit>(method: () async {
      pusherChannels.trigger(
        channel: 'private-chat-room',
        event: 'client-online',
        data: {
          'state': state,
          'senderId': senderId,
        },
      );
      return unit;
    });
  }
}
