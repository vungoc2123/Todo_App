import 'package:todo/domain/models/response/schedule/event_response.dart';

abstract class ScheduleRepository {
  Future<void> addNewEvent(EventResponse newEvent);

  Future<List<EventResponse>> getEvents(String selectedDate);

  Future<void> deleteEvent(String idEvent);

  Future<void> updateEvent(EventResponse event);

  Future<void> tickDoneEvent(EventResponse event);

  Future<List<EventResponse>> getAllEvent();
}
