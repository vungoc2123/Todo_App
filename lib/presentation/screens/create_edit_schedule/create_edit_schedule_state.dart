import 'package:equatable/equatable.dart';
import 'package:todo/application/enums/load_status.dart';
import 'package:todo/domain/models/response/schedule/event_response.dart';

class CreateEditScheduleState extends Equatable {
  final LoadStatus loadStatus;
  final EventResponse eventResponse;

  const CreateEditScheduleState(
      {this.loadStatus = LoadStatus.initial,
      this.eventResponse = const EventResponse(
          uId: "",
          title: "",
          date: "",
          startTime: "",
          endTime: "",
          content: "",
          status: false,
          idEvent: "")});

  CreateEditScheduleState copyWith(
      {LoadStatus? loadStatus, EventResponse? eventResponse}) {
    return CreateEditScheduleState(
        loadStatus: loadStatus ?? this.loadStatus,
        eventResponse: eventResponse ?? this.eventResponse);
  }

  @override
  List<Object?> get props => [loadStatus, eventResponse];
}
