import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/enums/load_status.dart';
import 'package:todo/di.dart';
import 'package:todo/domain/repositories/focus_repository.dart';
import 'package:todo/presentation/screens/report_focus/report_focus_state.dart';

class ReportFocusCubit extends Cubit<ReportFocusState> {
  final _repo = getIt<FocusRepository>();

  ReportFocusCubit() : super(const ReportFocusState());

  void setDates(List<String> newDates) {
    emit(state.copyWith(dates: newDates));
  }

  void setFromDate(DateTime date) {
    emit(state.copyWith(fromDate: date));
  }

  Future<void> getData() async {
    try {
      emit(state.copyWith(loadStatus: LoadStatus.loading));
      final response = await _repo.getReportFocus(state.dates);
      emit(state.copyWith(loadStatus: LoadStatus.success, data: response));
    } catch (e) {
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }
}
