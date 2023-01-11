// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      taskPriority:
          $enumDecodeNullable(_$TaskPriorityEnumMap, json['taskPriority']),
      isDone: json['isDone'] as bool?,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'taskPriority': _$TaskPriorityEnumMap[instance.taskPriority],
      'isDone': instance.isDone,
      'date': instance.date,
    };

const _$TaskPriorityEnumMap = {
  TaskPriority.URGENT: 'URGENT',
  TaskPriority.NOT_URGENT: 'NOT_URGENT',
  TaskPriority.IMPORTANT: 'IMPORTANT',
  TaskPriority.NOT_IMPORTANT: 'NOT_IMPORTANT',
};
