// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventResponse _$EventResponseFromJson(Map<String, dynamic> json) =>
    EventResponse(
      idEvent: json['idEvent'] as String? ?? "",
      uId: json['uId'] as String? ?? "",
      title: json['title'] as String? ?? "",
      date: json['date'] as String? ?? "",
      content: json['content'] as String? ?? "",
      startTime: json['startTime'] as String? ?? "",
      endTime: json['endTime'] as String? ?? "",
      status: json['status'] as bool? ?? false,
    );

Map<String, dynamic> _$EventResponseToJson(EventResponse instance) =>
    <String, dynamic>{
      'idEvent': instance.idEvent,
      'uId': instance.uId,
      'title': instance.title,
      'content': instance.content,
      'date': instance.date,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'status': instance.status,
    };
