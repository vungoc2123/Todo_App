import 'package:equatable/equatable.dart';
import 'package:todo/application/enums/focus_status.dart';

class FocusState extends Equatable {
  final double percentAnimation;
  final double time;
  final double timeRemaining;
  final String sound;
  final String timeText;
  final FocusStatus status;

  const FocusState(
      {this.percentAnimation = 0,
      this.timeText = '',
      this.time = 0,
      this.timeRemaining = 0,
      this.sound = '',
      this.status = FocusStatus.start});

  FocusState copyWith(
      {double? time,
      double? percentAnimation,
      String? timeText,
      String? sound,
      double? timeRemaining,
      FocusStatus? status}) {
    return FocusState(
        time: time ?? this.time,
        percentAnimation: percentAnimation ?? this.percentAnimation,
        timeText: timeText ?? this.timeText,
        timeRemaining: timeRemaining ?? this.timeRemaining,
        sound: sound ?? this.sound,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props =>
      [percentAnimation, timeText, sound, timeRemaining, time, status];
}
