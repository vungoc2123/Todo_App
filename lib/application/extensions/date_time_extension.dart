import 'package:flutter/material.dart';

extension DateTimeFormat on DateTime {
  String toFormattedString() {
    final day = this.day.toString().padLeft(2, '0');
    final month = this.month.toString().padLeft(2, '0');
    final year = this.year.toString();
    return '$day/$month/$year';
  }

  String toFormattedTimeString() {
    final hour = this.hour.toString().padLeft(2, '0');
    final minute = this.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

extension TimeOfDayFormat on TimeOfDay {
  String toFormattedString() {
    final hour = this.hour.toString().padLeft(2, '0');
    final minute = this.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  bool isStartTimeBeforeEndTime(TimeOfDay endTime){
    if(hour < endTime.hour){
      return true;
    }else if(hour == endTime.hour && minute < endTime.minute ){
      return true;
    }
    return false;
  }
}