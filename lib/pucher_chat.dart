library pusher_chat;

import 'chatting-pusher/data/models/chat_message_model.dart';
import 'chatting-pusher/data/models/chat_room_model.dart';
import 'core/injection/injectable.dart';
import 'core/isar/isar.dart';

Future<void> init() async {
  configureDependencies();
  final res = getIt<Isaar>();
  await res.openObject(
    schemas: [
      ChatMessageModelSchema,
      ChatRoomModelSchema,
    ],
    name: 'chatting_database',
  );
}
