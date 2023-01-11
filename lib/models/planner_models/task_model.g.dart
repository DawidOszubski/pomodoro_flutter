// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) => TaskModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      isImportant: json['isImportant'] as String?,
      isUrgent: json['isUrgent'] as String?,
      isDone: json['isDone'] as int?,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$TaskModelToJson(TaskModel instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'isImportant': instance.isImportant,
      'isUrgent': instance.isUrgent,
      'isDone': instance.isDone,
      'date': instance.date,
    };
