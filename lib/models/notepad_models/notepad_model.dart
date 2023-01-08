import 'package:json_annotation/json_annotation.dart';

part 'notepad_model.g.dart';

@JsonSerializable()
class NotepadModel {
  int? id;
  String? title;
  String? description;
  String? date;

  NotepadModel({this.id, this.title, this.description, this.date});

  factory NotepadModel.fromJson(Map<String, dynamic> json) =>
      _$NotepadModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotepadModelToJson(this);
}
