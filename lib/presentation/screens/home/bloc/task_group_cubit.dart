import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/enums/load_status.dart';
import 'package:todo/di.dart';
import 'package:todo/domain/models/response/task/task_group_response.dart';
import 'package:todo/domain/models/response/task/task_response.dart';
import 'package:todo/domain/repositories/task_group_repository.dart';
import 'package:todo/domain/repositories/task_repository.dart';
import 'package:todo/presentation/screens/home/bloc/task_group_state.dart';
import 'package:todo/presentation/screens/home/widgets/item_task.dart';

class TaskGroupCubit extends Cubit<TaskGroupState> {
  TaskGroupCubit() : super(const TaskGroupState());
  final repo = getIt.get<TaskGroupRepository>();
  final repoTask = getIt.get<TaskRepository>();
  final _auth = FirebaseAuth.instance;



  Future<void> addTaskGroup() async {
    try {
      emit(state.copyWith(status: LoadStatus.loading));
      TaskGroupResponse taskGroup = TaskGroupResponse(
          id: '',
          title: state.taskGroupResponse.title,
          color: state.taskGroupResponse.color,
          icon: state.taskGroupResponse.icon,
          totalTask: 0,
          createAt: DateTime.now().toString(),
          uid: _auth.currentUser?.uid ?? '');
      await repo.addTaskGroup(taskGroup);
      emit(state.copyWith(status: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }

  Future<void> getList() async {
    try {
      List<TaskGroupResponse> taskGroups =
          await repo.getList(_auth.currentUser?.uid ?? '');
      List<Future<ItemTaskGroupModel>> futures = taskGroups.map((e) async {
        List<TaskResponse> tasks = await repoTask.getList(
            idCate: e.id, uid: _auth.currentUser?.uid ?? '');
        List<TaskResponse> filterTasks =
            tasks.where((element) => element.status == true).toList();
        double percent =
            tasks.isNotEmpty ? filterTasks.length / tasks.length : 0;
        String percentText = (percent * 100).toStringAsFixed(1);
        return ItemTaskGroupModel(
            id: e.id,
            icon: e.icon,
            color: e.color,
            title: e.title,
            content: percentText,
            percent: percent,
            uid: e.uid,
            createAt: e.createAt,
            quantity: tasks.length);
      }).toList();
      List<ItemTaskGroupModel> listItem = await Future.wait(futures);
      emit(state.copyWith(taskGroups: listItem, status: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }

  Future<void> updateTaskGroup(TaskGroupResponse taskGroupResponse) async {
    try {
      emit(state.copyWith(status: LoadStatus.loading));
      TaskGroupResponse taskGroup = taskGroupResponse.copyWith(
        title: state.taskGroupResponse.title,
        color: state.taskGroupResponse.color,
        icon: state.taskGroupResponse.icon,
      );
      await repo.updateTaskGroup(taskGroup);
      emit(state.copyWith(status: LoadStatus.success));
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }

  Future<void> deleteTaskGroup(String id) async {
    try {
      List<ItemTaskGroupModel> list =
          List.from(state.taskGroups.where((element) => element.id != id));
      emit(state.copyWith(taskGroups: list));
      await repo.deleteTaskGroup(id);
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }

  void change({
    String? title,
    String? icon,
    String? color,
  }) {
    emit(state.copyWith(
        taskGroupResponse: state.taskGroupResponse.copyWith(
      title: title,
      icon: icon,
      color: color,
    )));
  }
}
