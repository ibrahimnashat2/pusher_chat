import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:pusher_chat/chatting-pusher/domain/entities/history.dart';

import '../../../../core/errors/failures.dart';
import '../repository/chat_repositroy.dart';

@lazySingleton
class GetHistory {
  final ChatRepository chatRepository;
  const GetHistory({required this.chatRepository});

  Future<Either<Failure, List<History>>> sendMessage({
    required int id,
    required int userId,
    required String roomId,
  }) async {
    return await chatRepository.getHistory();
  }
}
