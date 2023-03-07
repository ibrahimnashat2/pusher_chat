import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../entities/chat_room.dart';
import '../entities/chat_user.dart';
import '../repository/chat_repositroy.dart';

@lazySingleton
class SaveRoom {
  final ChatRepository chatRepository;
  const SaveRoom({required this.chatRepository});

  Future<Either<Failure, ChatRoom>> saveRoom({
    String? lastMessage,
    String? lastUpdated,
    required String roomId,
    required ChatUser user,
  }) async {
    return await chatRepository.saveRoom(
      lastMessage: lastMessage,
      lastUpdated: lastUpdated,
      roomId: roomId,
      user: user,
    );
  }
}
