import 'package:todo/domain/models/response/focus/focus_response.dart';
import 'package:todo/domain/models/response/report_focus/report_focus.dart';

abstract class FocusRepository{
  Future<void> addFocus(FocusResponse focusResponse);
  Future<List<ReportFocus>> getReportFocus(List<String> dates);
}
