// ignore_for_file: must_be_immutable, overridden_fields

import 'package:isar/isar.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/chat_room.dart';
import 'chat_user_model.dart';

part 'chat_room_model.g.dart';

@collection
@JsonSerializable()
class ChatRoomModel extends ChatRoom {
  @override
  final Id id;
  @override
  final ChatUserModel user;
  @JsonKey(name: "message")
  @override
  final String? lastMessage;
  @JsonKey(name: "createdAt")
  @override
  final String? lastUpdated;
  ChatRoomModel({
    this.id = Isar.autoIncrement,
    this.lastMessage,
    this.lastUpdated,
    required this.user,
    required super.roomId,
    super.lastCustomerService,
  }) : super(
          user: user,
          lastMessage: lastMessage,
          lastUpdated: lastUpdated,
        );

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) =>
      _$ChatRoomModelFromJson(json);

  Map<String, dynamic> toJson() => _$ChatRoomModelToJson(this);
}
