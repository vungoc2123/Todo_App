// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskResponse _$TaskResponseFromJson(Map<String, dynamic> json) => TaskResponse(
      id: json['id'] as String? ?? "",
      title: json['title'] as String? ?? "",
      status: json['status'] as bool? ?? false,
      priority: (json['priority'] as num?)?.toInt() ?? 1,
      idCate: json['idCate'] as String? ?? '',
      createAt: json['createAt'] as String? ?? '',
      timeUpdate: json['timeUpdate'] as String? ?? '',
      description: json['description'] as String?,
    );

Map<String, dynamic> _$TaskResponseToJson(TaskResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'idCate': instance.idCate,
      'title': instance.title,
      'description': instance.description,
      'status': instance.status,
      'priority': instance.priority,
      'createAt': instance.createAt,
      'timeUpdate': instance.timeUpdate,
    };
