import 'package:json_annotation/json_annotation.dart';

part 'task_group_response.g.dart';

@JsonSerializable()
class TaskGroupResponse {
  final String id;
  final String title;
  final int totalTask;
  final String icon;
  final String color;
  final String uid;
  final String createAt;

  const TaskGroupResponse(
      {this.id = '',
      this.title = '',
      this.totalTask = 0,
      this.icon = '',
      this.color = '',
      this.uid = '',
      this.createAt = ''});

  TaskGroupResponse copyWith(
      {String? id,
      String? title,
      int? totalTask,
      String? icon,
      String? color,
      String? createAt,
      String? uid}) {
    return TaskGroupResponse(
        id: id ?? this.id,
        title: title ?? this.title,
        totalTask: totalTask ?? this.totalTask,
        icon: icon ?? this.icon,
        color: color ?? this.color,
        createAt: createAt ?? this.createAt,
        uid: uid ?? this.uid);
  }

  factory TaskGroupResponse.fromJson(Map<String, dynamic> json) =>
      _$TaskGroupResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TaskGroupResponseToJson(this);
}
