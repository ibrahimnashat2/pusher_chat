import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../../../core/errors/exeption_handler.dart';
import '../../../../core/pusher/pusher_channels.dart';
import '../../../core/pusher/consts.dart';
import '../models/chat_message_model.dart';
import '../models/chat_user_model.dart';

abstract class ChatRemoteDataSource {
  Future<Unit> typing({
    required bool typing,
    required int senderId,
    required String roomId,
  });

  Future<Unit> online({
    required bool state,
    required int senderId,
    required int ownerId,
    required String roomId,
  });

  Future<ChatMessageModel> sendMessage({
    required dynamic message,
    required ChatUserModel sender,
    ChatUserModel? reciever,
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
    required Function() onDisconnecting,
    required Function() onDisconnected,
  });
}

@LazySingleton(as: ChatRemoteDataSource)
class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final PusherChannels pusherChannels;
  final ExceptionHandler handler;
  final PusherEnv pusherEnv;

  ChatRemoteDataSourceImpl({
    required this.pusherEnv,
    required this.pusherChannels,
    required this.handler,
  });

  @override
  Future<ChatMessageModel> sendMessage({
    required dynamic message,
    required ChatUserModel sender,
    ChatUserModel? reciever,
    required String type,
    required String roomId,
    required String messageId,
  }) async {
    return await handler<ChatMessageModel>(method: () async {
      final res = ChatMessageModel.fromJson({
        'message': message,
        'sender': sender.toJson(),
        'reciever': reciever?.toJson(),
        'type': type,
        'roomId': roomId,
        'messageId': messageId,
        'createdAt': DateTime.now().toIso8601String(),
      });
      pusherChannels.trigger(
        channel: pusherEnv.CHANNEL_NAME,
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
    required String roomId,
  }) async {
    return await handler<Unit>(method: () async {
      pusherChannels.trigger(
        channel: pusherEnv.CHANNEL_NAME,
        event: 'client-typing',
        data: {
          'typing': typing,
          'senderId': senderId,
          'roomId': roomId,
        },
      );
      return unit;
    });
  }

  @override
  Future<Unit> onListenPusher({
    required Function(PusherEvent) onEvent,
    required Function() onConnected,
    required Function() onDisconnecting,
    required Function() onDisconnected,
  }) async {
    return await handler<Unit>(method: () async {
      await pusherChannels.init(
        onEvent: onEvent,
        onConnected: onConnected,
        onDisconnected: onDisconnected,
        onDisconnecting: onDisconnecting,
      );
      pusherChannels.subscribe(
        channel: pusherEnv.CHANNEL_NAME,
      );
      return unit;
    });
  }

  @override
  Future<Unit> disconnect() async {
    return await handler<Unit>(method: () async {
      await pusherChannels.unsubscribe(channel: pusherEnv.CHANNEL_NAME);
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
        channel: pusherEnv.CHANNEL_NAME,
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
    required int ownerId,
    required String roomId,
  }) async {
    return await handler<Unit>(method: () async {
      pusherChannels.trigger(
        channel: pusherEnv.CHANNEL_NAME,
        event: 'client-online',
        data: {
          'state': state,
          'ownerId': ownerId,
          'senderId': senderId,
          'roomId': roomId,
        },
      );
      return unit;
    });
  }
}
