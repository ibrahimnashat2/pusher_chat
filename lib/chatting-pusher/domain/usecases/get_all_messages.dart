import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/chat_message.dart';
import '../repository/chat_repositroy.dart';

@lazySingleton
class GetAllMessages {
  final ChatRepository chatRepository;
  const GetAllMessages({required this.chatRepository});

  Future<Either<Failure, List<ChatMessage>>> getAllMessages({
    required String roomId,
  }) async {
    return await chatRepository.getAllMessages(roomId: roomId);
  }
}
