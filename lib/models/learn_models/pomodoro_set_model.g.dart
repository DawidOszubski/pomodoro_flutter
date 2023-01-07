// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pomodoro_set_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PomodoroSetModel _$PomodoroSetModelFromJson(Map<String, dynamic> json) =>
    PomodoroSetModel(
      id: json['id'] as int?,
      learnSectionTime: json['learnSectionTime'] as int?,
      breakTime: json['breakTime'] as int?,
    );

Map<String, dynamic> _$PomodoroSetModelToJson(PomodoroSetModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'learnSectionTime': instance.learnSectionTime,
      'breakTime': instance.breakTime,
    };
