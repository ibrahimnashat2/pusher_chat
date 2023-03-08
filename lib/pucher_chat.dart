library pusher_chat;

import 'chatting-pusher/data/models/chat_message_model.dart';
import 'chatting-pusher/data/models/chat_room_model.dart';
import 'chatting-pusher/data/models/history_model.dart';
import 'core/injection/injectable.dart';
import 'core/isar/isar.dart';

class PusherChat {
  static late final Isaar _isaar;

  static Future<void> init() async {
    configureDependencies();
    _isaar = getIt<Isaar>();
    await _isaar.openObject(
      schemas: [
        ChatMessageModelSchema,
        ChatRoomModelSchema,
        HistoryModelSchema,
      ],
      name: 'chatting_database',
    );
  }

  @pragma('vm:entry-point')
  static Future<void> saveRoomOrMessage(Map<String, dynamic> data) async {
    if (data['user'] != null) {
      _storeRoom(data);
    }
    if (data['message'] != null) {
      _storeMessage(data);
    }
  }

  @pragma('vm:entry-point')
  static Future<void> _storeRoom(Map<String, dynamic> data) async {
    await _isaar.writeOrUpdate<ChatRoomModel>(
      object: ChatRoomModel.fromJson(data),
    );
  }

  @pragma('vm:entry-point')
  static Future<void> _storeMessage(Map<String, dynamic> data) async {
    data["createdAt"] = DateTime.now().toIso8601String();
    await _storeRoom(data);
    await _isaar.writeOrUpdate<ChatMessageModel>(
      object: ChatMessageModel.fromJson(data),
    );
  }

  static Future<void> clear() async {
    await _isaar.clear();
  }
}
