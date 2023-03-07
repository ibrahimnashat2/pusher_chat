import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../repository/chat_repositroy.dart';

@lazySingleton
class Typing {
  final ChatRepository chatRepository;
  const Typing({required this.chatRepository});

  Future<Either<Failure, Unit>> typing({
    required bool typing,
    required int senderId,
  }) async {
    return await chatRepository.typing(typing: typing, senderId: senderId);
  }
}
