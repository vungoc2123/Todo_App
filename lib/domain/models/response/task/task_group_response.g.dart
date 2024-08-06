// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_group_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskGroupResponse _$TaskGroupResponseFromJson(Map<String, dynamic> json) =>
    TaskGroupResponse(
      id: json['id'] as String? ?? '',
      title: json['title'] as String? ?? '',
      totalTask: (json['totalTask'] as num?)?.toInt() ?? 0,
      icon: json['icon'] as String? ?? '',
      color: json['color'] as String? ?? '',
      uid: json['uid'] as String? ?? '',
      createAt: json['createAt'] as String? ?? '',
    );

Map<String, dynamic> _$TaskGroupResponseToJson(TaskGroupResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'totalTask': instance.totalTask,
      'icon': instance.icon,
      'color': instance.color,
      'uid': instance.uid,
      'createAt': instance.createAt,
    };
