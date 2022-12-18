import 'package:json_annotation/json_annotation.dart';

part 'pomodoro_set_model.g.dart';

@JsonSerializable()
class PomodoroSetModel {
  final int learnSectionTime;
  final int breakTime;

  PomodoroSetModel({required this.learnSectionTime, required this.breakTime});

  factory PomodoroSetModel.fromJson(Map<String, dynamic> json) =>
      _$PomodoroSetModelFromJson(json);

  Map<String, dynamic> toJson() => _$PomodoroSetModelToJson(this);
}
