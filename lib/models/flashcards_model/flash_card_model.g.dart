// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flash_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlashCardModel _$FlashCardModelFromJson(Map<String, dynamic> json) =>
    FlashCardModel(
      id: json['id'] as int?,
      title: json['title'] as String,
      subject: json['subject'] as String,
      progressCount: json['progressCount'] as int? ?? 0,
      flashcardCount: json['flashcardCount'] as int? ?? 0,
    );

Map<String, dynamic> _$FlashCardModelToJson(FlashCardModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subject': instance.subject,
      'progressCount': instance.progressCount,
      'flashcardCount': instance.flashcardCount,
    };
