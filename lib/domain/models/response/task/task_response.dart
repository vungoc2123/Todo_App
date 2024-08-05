import 'package:json_annotation/json_annotation.dart';

part 'task_response.g.dart';

@JsonSerializable()
class TaskResponse {
  final String id;
  final String idCate;
  final String title;
  final String? description;
  final bool status;
  final int priority;
  final String createAt;
  final String timeUpdate;

  const TaskResponse(
      {this.id = "",
      this.title = "",
      this.status = false,
      this.priority = 1,
      this.idCate = '',
      this.createAt = '',
      this.timeUpdate = '',
      this.description});

  TaskResponse copyWith({
    String? id,
    String? idCate,
    String? title,
    bool? status,
    int? priority,
    String? createAt,
    String? timeUpdate,
    String? description,
  }) {
    return TaskResponse(
      id: id ?? this.id,
      idCate: idCate ?? this.idCate,
      title: title ?? this.title,
      status: status ?? this.status,
      priority: priority ?? this.priority,
      createAt: createAt ?? this.createAt,
      timeUpdate: timeUpdate ?? this.timeUpdate,
      description: description ?? this.description,
    );
  }

  factory TaskResponse.fromJson(Map<String, dynamic> json) =>
      _$TaskResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TaskResponseToJson(this);
}
