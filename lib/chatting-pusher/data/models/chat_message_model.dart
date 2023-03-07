// ignore_for_file: must_be_immutable, overridden_fields

import 'package:json_annotation/json_annotation.dart';
import 'package:isar/isar.dart';

import '../../domain/entities/chat_message.dart';
part 'chat_message_model.g.dart';

@collection
@JsonSerializable()
class ChatMessageModel extends ChatMessage {
  @override
  Id id;
  ChatMessageModel({
    this.id = Isar.autoIncrement,
    required super.message,
    required super.senderId,
    required super.type,
    required super.roomId,
    super.createdAt,
    required super.messageId,
  }) : super(id: id);

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMessageModelToJson(this);
}
