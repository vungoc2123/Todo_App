import 'package:equatable/equatable.dart';
import 'package:todo/application/enums/load_status.dart';
import 'package:todo/domain/models/response/report_focus/report_focus.dart';

class ReportFocusState extends Equatable {
  final LoadStatus loadStatus;
  final List<ReportFocus> data;
  final List<String> dates;
  final DateTime? fromDate;

  const ReportFocusState(
      {this.loadStatus = LoadStatus.initial,
      this.data = const [],
      this.dates = const [],
      this.fromDate});

  ReportFocusState copyWith(
      {LoadStatus? loadStatus,
      List<ReportFocus>? data,
      List<String>? dates,
      DateTime? fromDate}) {
    return ReportFocusState(
        loadStatus: loadStatus ?? this.loadStatus,
        data: data ?? this.data,
        dates: dates ?? this.dates,
        fromDate: fromDate ?? this.fromDate);
  }

  @override
  List<Object?> get props => [loadStatus, data, dates, fromDate];
}
