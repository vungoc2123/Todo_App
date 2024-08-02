import 'package:equatable/equatable.dart';
import 'package:todo/application/enums/load_status.dart';
import 'package:todo/domain/models/response/schedule/event_response.dart';

class SchedulesState extends Equatable {
  final LoadStatus loadStatus;
  final LoadStatus loadAllStatus;
  final List<EventResponse> allEvents;
  final List<EventResponse> events;

  const SchedulesState({
    this.loadStatus = LoadStatus.initial,
    this.loadAllStatus = LoadStatus.initial,
    this.events = const [],
    this.allEvents= const [],
  });

  SchedulesState copyWith(
      {LoadStatus? loadStatus,
      LoadStatus? loadAllStatus,
      List<EventResponse>? events,
        List<EventResponse>? allEvents}) {
    return SchedulesState(
      loadStatus: loadStatus ?? this.loadStatus,
      loadAllStatus: loadAllStatus ?? this.loadAllStatus,
      allEvents: allEvents ?? this.allEvents,
      events: events ?? this.events,
    );
  }

  @override
  List<Object?> get props => [loadStatus, loadAllStatus, events,allEvents];
}
