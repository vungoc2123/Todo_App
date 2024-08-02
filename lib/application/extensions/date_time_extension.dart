import 'package:easy_localization/easy_localization.dart';
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
  String format2(){
     // Lấy thời gian hiện tại
    String formattedDate = DateFormat("yyyy-MM-dd HH:mm:ss.SSS'Z'").format(this.toUtc());
    return formattedDate;
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

  int toMinute(){
    return hour *60 + minute;
  }
}

extension StringToDateTime on String{

  TimeOfDay toTimeOfDay() {
    final parts = split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

  DateTime toDateTime() {
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy');
    DateTime date = dateFormat.parse(this).add(const Duration(hours: 7));
    return date;
  }

}