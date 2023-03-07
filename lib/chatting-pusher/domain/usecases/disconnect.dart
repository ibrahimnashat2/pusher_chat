import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../repository/chat_repositroy.dart';

@lazySingleton
class Disconnect {
  final ChatRepository chatRepository;
  const Disconnect({required this.chatRepository});

  Future<Either<Failure, Unit>> disconnect() async {
    return await chatRepository.disconnect();
  }
}
