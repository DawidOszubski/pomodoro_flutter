import 'package:json_annotation/json_annotation.dart';

part 'flash_card_model.g.dart';

@JsonSerializable()
class FlashCardModel {
  int? id;
  String title;
  String subject;
  int progressCount;
  int flashcardCount;

  FlashCardModel({
    this.id,
    required this.title,
    required this.subject,
    this.progressCount = 0,
    this.flashcardCount = 0,
  });

  factory FlashCardModel.fromJson(Map<String, dynamic> json) =>
      _$FlashCardModelFromJson(json);

  Map<String, dynamic> toJson() => _$FlashCardModelToJson(this);
}
