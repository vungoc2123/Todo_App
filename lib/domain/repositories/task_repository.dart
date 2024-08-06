import 'package:todo/domain/models/response/task/task_response.dart';

abstract class TaskRepository {
  Future<void> addTask(TaskResponse taskResponse);

  Future<List<TaskResponse>> getList(
      {String? idCate, bool? status, bool? isTimeUpdatedShort});

  Future<void> deleteTask(String id);

  Future<void> updateTask(TaskResponse taskResponse);
}
