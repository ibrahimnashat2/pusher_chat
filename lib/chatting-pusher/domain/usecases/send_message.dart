import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/chat_message.dart';
import '../repository/chat_repositroy.dart';

@lazySingleton
class SendMessage {
  final ChatRepository chatRepository;
  const SendMessage({required this.chatRepository});

  Future<Either<Failure, ChatMessage>> sendMessage({
    required dynamic message,
    required int senderId,
    required String type,
    required String roomId,
    required String messageId,
  }) async {
    return await chatRepository.sendMessage(
      message: message,
      senderId: senderId,
      type: type,
      roomId: roomId,
      messageId: messageId,
    );
  }
}
