import 'package:todo/domain/models/response/focus/focus_response.dart';

abstract class FocusRepository{
  Future<void> addFocus(FocusResponse focusResponse);
  Future<List<FocusResponse>> getList(String uid);

}
