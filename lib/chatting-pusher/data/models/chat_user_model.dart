// ignore_for_file: must_be_immutable, overridden_fields

import 'package:json_annotation/json_annotation.dart';
import 'package:isar/isar.dart';

import '../../domain/entities/chat_user.dart';
part 'chat_user_model.g.dart';

@embedded
@JsonSerializable()
class ChatUserModel extends ChatUser {
  ChatUserModel({
    super.id,
    super.name,
    super.image,
  });

  factory ChatUserModel.fromJson(Map<String, dynamic> json) =>
      _$ChatUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$ChatUserModelToJson(this);
}
