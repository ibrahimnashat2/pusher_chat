import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../repository/chat_repositroy.dart';

@lazySingleton
class Online {
  final ChatRepository chatRepository;
  const Online({required this.chatRepository});

  Future<Either<Failure, Unit>> online({
    required bool state,
    required int senderId,
    required int ownerId,
    required String roomId,
  }) async {
    return await chatRepository.online(
      state: state,
      senderId: senderId,
      ownerId: ownerId,
      roomId: roomId,
    );
  }
}
