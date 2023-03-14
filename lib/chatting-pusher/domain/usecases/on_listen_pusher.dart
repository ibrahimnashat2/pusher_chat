import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

import '../../../../core/errors/failures.dart';
import '../repository/chat_repositroy.dart';

@lazySingleton
class OnListenPusher {
  final ChatRepository chatRepository;
  const OnListenPusher({required this.chatRepository});

  Future<Either<Failure, Unit>> onListenPusher({
    required Function(PusherEvent) onEvent,
    required Function() onConnected,
    required Function() onDisconnecting,
    required Function() onDisconnected,
  }) async {
    return await chatRepository.onListenPusher(
      onEvent: onEvent,
      onConnected: onConnected,
      onDisconnected: onDisconnected,
      onDisconnecting: onDisconnecting,
    );
  }
}
