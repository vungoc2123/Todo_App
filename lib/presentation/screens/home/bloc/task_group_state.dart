import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/application/enums/load_status.dart';
import 'package:todo/domain/models/response/task/task_group_response.dart';
import 'package:todo/presentation/screens/home/widgets/item_task.dart';

class TaskGroupState extends Equatable {
  final List<ItemTaskGroupModel> taskGroups;
  final TaskGroupResponse taskGroupResponse;
  final LoadStatus status;
  const TaskGroupState(
      {this.taskGroupResponse = const TaskGroupResponse(),
      this.status = LoadStatus.initial,
      this.taskGroups = const []});

  TaskGroupState copyWith(
      {List<ItemTaskGroupModel>? taskGroups,
      LoadStatus? status,
      TaskGroupResponse? taskGroupResponse}) {
    return TaskGroupState(
        taskGroups: taskGroups ?? this.taskGroups,
        status: status ?? this.status,
        taskGroupResponse: taskGroupResponse ?? this.taskGroupResponse);
  }

  @override
  List<Object?> get props => [taskGroups, taskGroupResponse, status];
}
