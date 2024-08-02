import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/enums/load_status.dart';
import 'package:todo/application/extensions/date_time_extension.dart';
import 'package:todo/di.dart';
import 'package:todo/domain/repositories/schedule/schedule_repository.dart';
import 'package:todo/presentation/screens/schedule/schedules_state.dart';

class SchedulesCubit extends Cubit<SchedulesState> {
  final _scheduleRepo = getIt<ScheduleRepository>();

  SchedulesCubit() : super(const SchedulesState());

  Future<void> getEventByDate(String selectedDate) async {
    try {
      emit(state.copyWith(loadStatus: LoadStatus.loading));
      final response = await _scheduleRepo.getEvents(selectedDate);
      response.sort((a, b) => a.startTime
          .toTimeOfDay()
          .toMinute()
          .compareTo(b.startTime.toTimeOfDay().toMinute()));
      emit(state.copyWith(loadStatus: LoadStatus.success, events: response));
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }

  Future<void> getAllEvent() async {
    try {
      emit(state.copyWith(loadAllStatus: LoadStatus.loading));
      final response = await _scheduleRepo.getAllEvent();
      emit(state.copyWith(
          loadAllStatus: LoadStatus.success, allEvents: response));
    } catch (e) {
      emit(state.copyWith(loadAllStatus: LoadStatus.failure));
    }
  }
}
