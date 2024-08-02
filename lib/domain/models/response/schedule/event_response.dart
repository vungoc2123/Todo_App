import 'package:json_annotation/json_annotation.dart';

part 'event_response.g.dart';

@JsonSerializable()
class EventResponse {
  final String idEvent;
  final String uId;
  final String title;
  final String? content;
  final String date;
  final String startTime;
  final String endTime;
  final bool status;

  const EventResponse(
      {this.idEvent = "",
      this.uId = "",
      this.title = "",
      this.date = "",
      this.content = "",
      this.startTime = "",
      this.endTime = "",
      this.status = false});

  EventResponse copyWith(
      {String? idEvent,
      String? uId,
      String? title,
      String? content,
      String? date,
      String? startTime,
      String? endTime,
      bool? status}) {
    return EventResponse(
        idEvent: idEvent ?? this.idEvent,
        uId: uId ?? this.uId,
        title: title ?? this.title,
        content: content ?? this.content,
        date: date ?? this.date,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        status: status ?? this.status);
  }

  factory EventResponse.fromJson(Map<String, dynamic> json) =>
      _$EventResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EventResponseToJson(this);
}
