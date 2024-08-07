import 'package:equatable/equatable.dart';
import 'package:todo/application/enums/load_status.dart';
import 'package:todo/domain/models/response/task/task_response.dart';

class ListTaskState extends Equatable {
  final List<TaskResponse> listTask;
  final List<TaskResponse> listTaskCompleted;
  final List<TaskResponse> listTaskInit;
  final List<TaskResponse> listTaskCompletedInit;
  final TaskResponse taskResponse;
  final LoadStatus status;

  const ListTaskState(
      {this.taskResponse = const TaskResponse(),
      this.listTask = const [],
      this.listTaskInit = const [],
      this.listTaskCompletedInit = const [],
      this.listTaskCompleted = const [],
      this.status = LoadStatus.initial});

  ListTaskState copyWith(
      {TaskResponse? taskResponse,
      List<TaskResponse>? listTask,
      LoadStatus? status,
      List<TaskResponse>? listTaskInit,
      List<TaskResponse>? listTaskCompletedInit,
      List<TaskResponse>? listTaskCompleted}) {
    return ListTaskState(
        taskResponse: taskResponse ?? this.taskResponse,
        status: status ?? this.status,
        listTask: listTask ?? this.listTask,
        listTaskInit: listTaskInit ?? this.listTaskInit,
        listTaskCompleted: listTaskCompleted ?? this.listTaskCompleted,
        listTaskCompletedInit:
            listTaskCompletedInit ?? this.listTaskCompletedInit);
  }

  @override
  List<Object?> get props => [
        status,
        listTask,
        listTaskCompleted,
        listTaskInit,
        listTaskCompletedInit,
        taskResponse
      ];
}
