import 'package:json_annotation/json_annotation.dart';

part 'flashcard_item_model.g.dart';

@JsonSerializable()
class FlashcardItemModel {
  int? id;
  String question;
  String? answerText;
  bool? answerTF;
  String? answerMultipleChoice;
  int flashcardSetId;

  FlashcardItemModel(
      {this.id,
      required this.question,
      this.answerText,
      this.answerTF,
      this.answerMultipleChoice,
      required this.flashcardSetId});

  factory FlashcardItemModel.fromJson(Map<String, dynamic> json) =>
      _$FlashcardItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$FlashcardItemModelToJson(this);
}
