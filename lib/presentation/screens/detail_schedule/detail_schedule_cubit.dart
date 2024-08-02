import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/enums/load_status.dart';
import 'package:todo/di.dart';
import 'package:todo/domain/models/response/schedule/event_response.dart';
import 'package:todo/domain/repositories/schedule/schedule_repository.dart';
import 'package:todo/presentation/screens/detail_schedule/detail_schedule_state.dart';

class DetailScheduleCubit extends Cubit<DetailScheduleState> {
  DetailScheduleCubit() : super(const DetailScheduleState());

  final _scheduleRepo = getIt<ScheduleRepository>();

  Future<void> deleteEvent(String idEvent) async {
    try {
      emit(state.copyWith(loadStatus: LoadStatus.loading));
      await _scheduleRepo.deleteEvent(idEvent);
      emit(state.copyWith(loadStatus: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }

  Future<void> changeStatusEvent(EventResponse event) async {
    try {
      emit(state.copyWith(loadStatus: LoadStatus.loading));
      await _scheduleRepo.tickDoneEvent(event);
      emit(state.copyWith(loadStatus: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }
}
