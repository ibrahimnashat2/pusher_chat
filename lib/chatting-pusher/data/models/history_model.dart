// ignore_for_file: must_be_immutable, overridden_fields

import 'package:json_annotation/json_annotation.dart';
import 'package:isar/isar.dart';

import '../../domain/entities/history.dart';
part 'history_model.g.dart';

@collection
@JsonSerializable()
class HistoryModel extends History {
  @override
  Id id;
  HistoryModel({
    this.id = Isar.autoIncrement,
    required super.userId,
    required super.roomId,
  }) : super(id: id);

  factory HistoryModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$HistoryModelToJson(this);
}
