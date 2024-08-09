import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:todo/application/enums/focus_status.dart';
import 'package:todo/application/extensions/date_time_extension.dart';
import 'package:todo/application/extensions/double_extension.dart';
import 'package:todo/di.dart';
import 'package:todo/domain/models/response/focus/focus_response.dart';
import 'package:todo/domain/repositories/focus_repository.dart';
import 'package:todo/presentation/screens/focus/bloc/focus_state.dart';
import 'package:todo/application/configs/notification_service.dart';

class FocusCubit extends Cubit<FocusState> {
  FocusCubit() : super(const FocusState());
  final notification = getIt<NotificationService>();
  final repo = getIt<FocusRepository>();
  final _auth = FirebaseAuth.instance;
  late Timer _timer;
  AudioPlayer? player;

  Future<void> addFocus() async {
    double timeCompleted = state.time - state.timeRemaining;
    FocusResponse focus = FocusResponse(
        id: '',
        uid: _auth.currentUser?.uid ?? '',
        dateTime: DateTime.now().toFormattedString(),
        completedTime: timeCompleted);
    repo.addFocus(focus);
  }

  void chooseSound(String sound) {
    emit(state.copyWith(sound: sound));
    _disposePlayerAndTimer();
    if (state.status != FocusStatus.pause) {
      start();
    }
  }

  void handleGetTime(DateTime time) {
    double totalTime = time.getTotalMinutes().toDouble();
    emit(state.copyWith(time: totalTime, timeRemaining: totalTime));
  }

  Future<void> _playSound() async {
    if (player == null) {
      if (state.sound.isEmpty) return;
      player = AudioPlayer();
      await player?.setAsset(state.sound);
      player?.setLoopMode(LoopMode.one);
      await player?.play();
      return;
    }
    await player?.play();
  }

  void start() {
    double totalTime = state.time;
    double totalTimeRemaining = state.timeRemaining;
    if (totalTime <= 0) return;
    _playSound();
    emit(state.copyWith(status: FocusStatus.playing));
    _runTimer(tTotal: totalTime, tRem: totalTimeRemaining);
  }

  void _runTimer({required double tTotal, required double tRem}) {
    double pctTime = 1 / (tTotal * 100);
    double pctTimeRem = 10 / 1000;
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      tRem -= pctTimeRem;
      double totalPercent = state.percentAnimation + pctTime;
      if (totalPercent >= 1 && tRem <= 0) {
        showNotification();
        cancel();
        return;
      }
      emit(state.copyWith(
          percentAnimation: totalPercent.clamp(0, 1),
          timeText: tRem.formatMinutes(),
          timeRemaining: tRem));
    });
  }

  void showNotification() {
    notification.showNotification(
        id: 0, title: tr('finishFocus'), body: tr("restFocus"));
  }

  void pauseOrPlaying() {
    _timer.cancel();
    player?.pause();
    if (state.status == FocusStatus.playing) {
      emit(state.copyWith(status: FocusStatus.pause));
      return;
    }
    start();
  }

  void cancel() {
    _disposePlayerAndTimer();
    addFocus();
    emit(state.copyWith(
        status: FocusStatus.start,
        timeText: '',
        percentAnimation: 0,
        time: 0,
        timeRemaining: 0));
  }

  void _disposePlayerAndTimer() {
    player?.dispose();
    player = null;
    _timer.cancel();
  }
}
