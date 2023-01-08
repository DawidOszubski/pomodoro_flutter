// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notepad_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotepadModel _$NotepadModelFromJson(Map<String, dynamic> json) => NotepadModel(
      id: json['id'] as int?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      date: json['date'] as String?,
    );

Map<String, dynamic> _$NotepadModelToJson(NotepadModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'date': instance.date,
    };
