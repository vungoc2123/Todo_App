import 'package:todo/domain/models/response/task/task_group_response.dart';

abstract class TaskGroupRepository{
  Future<void> addTaskGroup(TaskGroupResponse taskGroupResponse);
  Future<List<TaskGroupResponse>> getList(String uid);
  Future<void> deleteTaskGroup(String id);
  Future<void> updateTaskGroup(TaskGroupResponse taskGroupResponse);
}