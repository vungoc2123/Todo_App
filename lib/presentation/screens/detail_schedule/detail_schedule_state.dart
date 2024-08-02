import 'package:equatable/equatable.dart';
import 'package:todo/application/enums/load_status.dart';

class DetailScheduleState extends Equatable {
  final LoadStatus loadStatus;

  const DetailScheduleState({this.loadStatus = LoadStatus.initial});

  DetailScheduleState copyWith({LoadStatus? loadStatus}){
    return DetailScheduleState(loadStatus: loadStatus ?? this.loadStatus);
  }
  @override
  List<Object?> get props => [loadStatus];
}
