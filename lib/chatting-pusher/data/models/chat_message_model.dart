// ignore_for_file: must_be_immutable, overridden_fields

import 'package:json_annotation/json_annotation.dart';
import 'package:isar/isar.dart';

import '../../domain/entities/chat_message.dart';
import 'chat_user_model.dart';
part 'chat_message_model.g.dart';

@collection
@JsonSerializable()
class ChatMessageModel extends ChatMessage {
  @override
  Id id;
  @override
  ChatUserModel sender;
  @override
  ChatUserModel? reciever;
  ChatMessageModel({
    this.id = Isar.autoIncrement,
    required super.message,
    required this.sender,
    required super.type,
    required super.roomId,
    super.createdAt,
    this.reciever,
    required super.messageId,
  }) : super(id: id, sender: sender, reciever: reciever);

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      _$ChatMessageModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatMessageModelToJson(this);
}
