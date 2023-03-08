import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../repository/chat_repositroy.dart';

@lazySingleton
class SaveHistory {
  final ChatRepository chatRepository;
  const SaveHistory({required this.chatRepository});

  Future<Either<Failure, Unit>> saveHistory({
    required int id,
    required int userId,
    required String roomId,
  }) async {
    return await chatRepository.saveHistory(
      id: id,
      userId: userId,
      roomId: roomId,
    );
  }
}
