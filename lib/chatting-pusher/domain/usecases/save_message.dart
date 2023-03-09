import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/errors/failures.dart';
import '../../data/models/chat_user_model.dart';
import '../repository/chat_repositroy.dart';

@lazySingleton
class SaveMessage {
  final ChatRepository chatRepository;
  const SaveMessage({required this.chatRepository});

  Future<Either<Failure, Unit>> saveMessage({
    required String message,
    required ChatUserModel sender,
    ChatUserModel? reciever,
    required String type,
    required String roomId,
    required String messageId,
  }) async {
    return await chatRepository.saveMessage(
      message: message,
      reciever: reciever,
      sender: sender,
      type: type,
      roomId: roomId,
      messageId: messageId,
    );
  }
}
