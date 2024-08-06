// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'focus_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FocusResponse _$FocusResponseFromJson(Map<String, dynamic> json) =>
    FocusResponse(
      id: json['id'] as String? ?? '',
      uID: json['uID'] as String? ?? '',
      completedTime: (json['completedTime'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$FocusResponseToJson(FocusResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uID': instance.uID,
      'completedTime': instance.completedTime,
    };
