// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flashcard_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FlashcardItemModel _$FlashcardItemModelFromJson(Map<String, dynamic> json) =>
    FlashcardItemModel(
      id: json['id'] as int?,
      question: json['question'] as String,
      answerText: json['answerText'] as String?,
      answerTF: json['answerTF'] as bool?,
      answerMultipleChoice: json['answerMultipleChoice'] as String?,
      flashcardSetId: json['flashcardSetId'] as int,
    );

Map<String, dynamic> _$FlashcardItemModelToJson(FlashcardItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'answerText': instance.answerText,
      'answerTF': instance.answerTF,
      'answerMultipleChoice': instance.answerMultipleChoice,
      'flashcardSetId': instance.flashcardSetId,
    };
