import 'package:json_annotation/json_annotation.dart';

part 'focus_response.g.dart';

@JsonSerializable()
class FocusResponse {
  final String id;
  final String uID;
  final double completedTime;

  FocusResponse({this.id = '', this.uID = '', this.completedTime = 0});

  FocusResponse copyWith(String? id, String? uID, double? completedTime) {
    return FocusResponse(
        id: id ?? this.id,
        uID: uID ?? this.uID,
        completedTime: completedTime ?? this.completedTime);
  }

  factory FocusResponse.fromJson(Map<String, dynamic> json) =>
      _$FocusResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FocusResponseToJson(this);
}
