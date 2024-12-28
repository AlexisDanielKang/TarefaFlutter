import 'package:json_annotation/json_annotation.dart';

part 'task_model.g.dart';

@JsonSerializable()
class TaskModel {
  final String? id;
  final String title;
  final String? describe;
  final bool isCompleted;

  TaskModel({
    this.id,
    required this.title,
    this.describe,
    required this.isCompleted});

  factory TaskModel.fromJson(Map<String, dynamic> json) =>
      _$TaskModelFromJson(json);

  Map<String, dynamic> toJson() => _$TaskModelToJson(this);
}
