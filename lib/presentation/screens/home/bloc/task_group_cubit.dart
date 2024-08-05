import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/constants/app_colors.dart';
import 'package:todo/application/enums/load_status.dart';
import 'package:todo/di.dart';
import 'package:todo/domain/models/response/task/task_group_response.dart';
import 'package:todo/domain/models/response/task/task_response.dart';
import 'package:todo/domain/repositories/task_group_repository.dart';
import 'package:todo/domain/repositories/task_repository.dart';
import 'package:todo/gen/assets.gen.dart';
import 'package:todo/presentation/screens/home/bloc/task_group_state.dart';
import 'package:todo/presentation/screens/home/widgets/item_task.dart';

final List<Color> listColor = [
  AppColors.grey,
  AppColors.blue,
  AppColors.yellow,
  AppColors.pinkSubText,
  AppColors.black,
  AppColors.red,
  AppColors.green,
];

List<String> listIcon = [
  Assets.icons.briefcase.path,
  Assets.icons.puzzlePieces.path,
  Assets.icons.bookOpenCover.path,
  Assets.icons.walking.path,
  Assets.icons.userChef.path,
];

class TaskGroupCubit extends Cubit<TaskGroupState> {
  TaskGroupCubit() : super(const TaskGroupState());
  final repo = getIt.get<TaskGroupRepository>();
  final repoTask = getIt.get<TaskRepository>();

  Future<void> addTaskGroup() async {
    emit(state.copyWith(status: LoadStatus.loading));
    TaskGroupResponse taskGroup = TaskGroupResponse(
        id: '',
        title: state.taskGroupResponse.title,
        color: state.taskGroupResponse.color,
        icon: state.taskGroupResponse.icon,
        totalTask: 0);
    await repo.addTaskGroup(taskGroup);
    emit(state.copyWith(status: LoadStatus.success));
  }

  Future<void> getList() async {
    List<TaskGroupResponse> taskGroups = await repo.getList();
    List<Future<ItemTaskGroupModel>> futures = taskGroups.map((e) async {
      List<TaskResponse> tasks = await repoTask.getList(idCate: e.id);
      List<TaskResponse> filterTasks =
          tasks.where((element) => element.status == true).toList();
      double percent = tasks.isNotEmpty ? filterTasks.length / tasks.length : 0;
      String percentText = (percent * 100).toStringAsFixed(1);
      return ItemTaskGroupModel(
          id: e.id,
          icon: e.icon,
          color: e.color,
          title: e.title,
          content: percentText,
          percent: percent,
          quantity: tasks.length);
    }).toList();
    List<ItemTaskGroupModel> listItem = await Future.wait(futures);
    emit(state.copyWith(taskGroups: listItem, status: LoadStatus.success));
  }

  Future<void> updateTaskGroup() async {
    emit(state.copyWith(status: LoadStatus.loading));
    TaskGroupResponse taskGroup = TaskGroupResponse(
        id: state.taskGroupResponse.id,
        title: state.taskGroupResponse.title,
        color: state.taskGroupResponse.color,
        icon: state.taskGroupResponse.icon,
        totalTask: 0);
    await repo.updateTaskGroup(taskGroup);
    emit(state.copyWith(status: LoadStatus.success));
  }

  Future<void> deleteTaskGroup(String id) async {
    List<ItemTaskGroupModel> list =
        List.from(state.taskGroups.where((element) => element.id != id));
    emit(state.copyWith(taskGroups: list));
    await repo.deleteTaskGroup(id);
  }

  void change({String? id, String? title, String? icon, String? color}) {
    emit(state.copyWith(
        taskGroupResponse: state.taskGroupResponse
            .copyWith(id: id, title: title, icon: icon, color: color)));
  }
}
