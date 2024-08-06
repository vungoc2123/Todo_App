import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/application/enums/load_status.dart';
import 'package:todo/di.dart';
import 'package:todo/domain/models/response/task/task_response.dart';
import 'package:todo/domain/repositories/task_repository.dart';
import 'package:todo/presentation/screens/list_task/bloc/list_task_state.dart';
import 'package:bloc/bloc.dart';

class ListTaskCubit extends Cubit<ListTaskState> {
  ListTaskCubit() : super(const ListTaskState());
  final _auth = FirebaseAuth.instance;
  final repo = getIt.get<TaskRepository>();

  Future<void> addTask(String idTaskGroup) async {
    emit(state.copyWith(status: LoadStatus.loading));
    TaskResponse taskResponse = TaskResponse(
        id: '',
        title: state.taskResponse.title,
        description: state.taskResponse.description,
        idCate: idTaskGroup,
        status: false,
        priority: 0,
        uid: _auth.currentUser?.uid ?? '',
        createAt: DateTime.now().toString(),
        timeUpdate: DateTime.now().toString());
    await repo.addTask(taskResponse);
    emit(state.copyWith(status: LoadStatus.success));
  }

  Future<void> getList(String idCate) async {
    List<TaskResponse> tasks = await repo.getList(
        idCate: idCate, uid: _auth.currentUser?.uid ?? '', status: false);
    List<TaskResponse> tasksCompleted = await repo.getList(
        uid: _auth.currentUser?.uid ?? '',
        idCate: idCate,
        status: true,
        isTimeUpdatedShort: true);
    emit(state.copyWith(
        listTask: tasks,
        listTaskCompleted: tasksCompleted,
        status: LoadStatus.success));
  }

  Future<void> updateTask(TaskResponse taskResponse) async {
    emit(state.copyWith(status: LoadStatus.loading));
    TaskResponse newTask = taskResponse.copyWith(
        title: state.taskResponse.title,
        description: state.taskResponse.description,
        status: state.taskResponse.status,
        timeUpdate: DateTime.now().toString(),
        priority: 0);
    await repo.updateTask(newTask);
    emit(state.copyWith(status: LoadStatus.success));
  }

  Future<void> deleteTask(String id) async {
    await repo.deleteTask(id);
  }

  void change(
      {
      String? name,
      String? description,
      bool? status}) {
    emit(state.copyWith(
        taskResponse: state.taskResponse.copyWith(
            title: name,
            description: description,
            status: status)));
  }

  void handleListVirtual(TaskResponse taskResponse, bool status) {
    List<TaskResponse> newList = List.from(state.listTask);
    List<TaskResponse> newListCompleted = List.from(state.listTaskCompleted);
    if (status) {
      handleChangeStatus(newList, newListCompleted, taskResponse.id, status);
    } else {
      handleChangeStatus(newListCompleted, newList, taskResponse.id, status);
    }
    handleSortListVirtual(newList);
    emit(
        state.copyWith(listTaskCompleted: newListCompleted, listTask: newList));
  }

  void handleChangeStatus(List<TaskResponse> list, List<TaskResponse> newList,
      String id, bool status) {
    TaskResponse task = list.firstWhere((element) => element.id == id);
    list.remove(task);
    newList.insert(0, task.copyWith(status: status));
  }

  void handleSortListVirtual(List<TaskResponse> list) {
    list.sort((a, b) {
      DateTime dateA = DateTime.parse(a.createAt);
      DateTime dateB = DateTime.parse(b.createAt);
      return dateB.compareTo(dateA);
    });
  }

  void handleDeleteListVirtual(String id) {
    deleteTask(id);
    if (state.listTask.any((element) => element.id == id)) {
      List<TaskResponse> newList = List.from(state.listTask);
      TaskResponse task =
          state.listTask.firstWhere((element) => element.id == id);
      newList.remove(task);
      emit(state.copyWith(listTask: newList));
    } else {
      List<TaskResponse> newListCompleted = List.from(state.listTaskCompleted);
      TaskResponse taskCompleted =
          state.listTaskCompleted.firstWhere((element) => element.id == id);
      newListCompleted.remove(taskCompleted);
      emit(state.copyWith(listTaskCompleted: newListCompleted));
    }
  }

  void changeStatusTask(TaskResponse taskResponse, bool status) {
    handleListVirtual(taskResponse, status);
    change(
        name: taskResponse.title,
        description: taskResponse.description,
        status: status);
    updateTask(taskResponse);
  }
}
