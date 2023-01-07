import 'package:json_annotation/json_annotation.dart';

part 'test_model.g.dart';

@JsonSerializable()
class TestModel {
  int? id;
  String? title;
  String? description;
  DateTime? date;
  String? subject;
  int? flashCardSetId;
  int? noteId;

  TestModel(
      {this.id,
      this.title,
      this.description,
      this.date,
      this.subject,
      this.flashCardSetId,
      this.noteId});

  factory TestModel.fromJson(Map<String, dynamic> json) =>
      _$TestModelFromJson(json);

  Map<String, dynamic> toJson() => _$TestModelToJson(this);
}
