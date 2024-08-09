import 'package:json_annotation/json_annotation.dart';

part 'focus_response.g.dart';

@JsonSerializable()
class FocusResponse {
  final String id;
  final String uid;
  final String dateTime;
  final double completedTime;

  FocusResponse(
      {this.id = '',
      this.uid = '',
      this.dateTime = '',
      this.completedTime = 0});

  FocusResponse copyWith(
      String? id, String? uid, String? dateTime, double? completedTime) {
    return FocusResponse(
        id: id ?? this.id,
        uid: uid ?? this.uid,
        dateTime: dateTime ?? this.dateTime,
        completedTime: completedTime ?? this.completedTime);
  }

  factory FocusResponse.fromJson(Map<String, dynamic> json) =>
      _$FocusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FocusResponseToJson(this);
}
