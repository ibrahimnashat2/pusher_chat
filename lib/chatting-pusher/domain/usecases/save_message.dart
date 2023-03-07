import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../repository/chat_repositroy.dart';

@lazySingleton
class SaveMessage {
  final ChatRepository chatRepository;
  const SaveMessage({required this.chatRepository});

  Future<Either<Failure, Unit>> saveMessage({
    required String message,
    required int senderId,
    required String type,
    required String roomId,
    required String messageId,
  }) async {
    return await chatRepository.saveMessage(
      message: message,
      senderId: senderId,
      type: type,
      roomId: roomId,
      messageId: messageId,
    );
  }
}
