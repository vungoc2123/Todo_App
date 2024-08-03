import 'package:equatable/equatable.dart';
import 'package:todo/application/enums/load_status.dart';
import 'package:todo/domain/models/response/task/task_response.dart';

class ListTaskState extends Equatable {
  final List<TaskResponse> listTask;
  final List<TaskResponse> listTaskCompleted;
  final TaskResponse taskResponse;
  final LoadStatus status;

  const ListTaskState(
      {this.taskResponse = const TaskResponse(),
      this.listTask = const [],
      this.status = LoadStatus.initial,
      this.listTaskCompleted = const []});

  ListTaskState copyWith(
      {TaskResponse? taskResponse,
      List<TaskResponse>? listTask,
      LoadStatus? status,
      List<TaskResponse>? listTaskCompleted}) {
    return ListTaskState(
        taskResponse: taskResponse ?? this.taskResponse,
        listTask: listTask ?? this.listTask,
        status: status ?? this.status,
        listTaskCompleted: listTaskCompleted ?? this.listTaskCompleted);
  }

  @override
  List<Object?> get props =>
      [listTask, status, listTaskCompleted, taskResponse];
}
