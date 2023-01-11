import 'package:json_annotation/json_annotation.dart';

import '../enum/planner_enum.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel {
  int? id;
  String? title;
  String? description;
  TaskPriority? taskPriority;
  bool? isDone;
  String? date;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.taskPriority,
    this.isDone,
    this.date,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);
}
