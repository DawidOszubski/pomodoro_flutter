import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel {
  int? id;
  String? title;
  String? description;
  String? isImportant;
  String? isUrgent;
  int? isDone;
  String? date;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.isImportant,
    this.isUrgent,
    this.isDone,
    this.date,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);
}
