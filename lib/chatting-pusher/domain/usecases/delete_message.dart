import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../repository/chat_repositroy.dart';

@lazySingleton
class DeleteMessage {
  final ChatRepository chatRepository;
  const DeleteMessage({required this.chatRepository});

  Future<Either<Failure, Unit>> deleteMessage({
    required int id,
    required int senderId,
  }) async {
    return await chatRepository.deleteMessage(id: id, senderId: senderId);
  }
}
