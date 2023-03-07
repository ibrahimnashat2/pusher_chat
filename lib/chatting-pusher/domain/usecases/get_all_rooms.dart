import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/chat_room.dart';
import '../repository/chat_repositroy.dart';

@lazySingleton
class GetAllRooms {
  final ChatRepository chatRepository;
  const GetAllRooms({required this.chatRepository});

  Future<Either<Failure, List<ChatRoom>>> getAllRooms() async {
    return await chatRepository.getAllRooms();
  }
}
