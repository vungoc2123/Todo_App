import 'package:todo/domain/models/response/schedule/event_response.dart';

abstract class ScheduleRepository{
  Future<void> addNewEvent(EventResponse newEvent);
}