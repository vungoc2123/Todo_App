import 'package:flutter/material.dart';

class Event {
  final String title;
  final String? content;
  final DateTime? date;
  final TimeOfDay? start;
  final TimeOfDay? end;
  final bool? status;

  const Event(
      {required this.title,
      this.date,
      this.content,
      this.start,
      this.end,
      this.status = false});

  Event copyWith(
      {String? title,
      String? content,
      DateTime? date,
      TimeOfDay? start,
      TimeOfDay? end,
      bool? status}) {
    return Event(
        title: title ?? this.title,
        content: content ?? this.content,
        date: date ?? this.date,
        start: start ?? this.start,
        end: end ?? this.end,
        status: status ?? this.status);
  }
}
