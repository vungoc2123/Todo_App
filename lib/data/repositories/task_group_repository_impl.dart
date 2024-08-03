import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/domain/models/response/task/task_group_response.dart';
import 'package:todo/domain/repositories/task_group_repository.dart';

class TaskGroupRepositoryImpl implements TaskGroupRepository {
  final db = FirebaseFirestore.instance;
  String name = "taskGroups";

  @override
  Future<void> addTaskGroup(TaskGroupResponse taskGroupResponse) async {
    try {
      final ref = await db.collection(name).add(taskGroupResponse.toJson());
      await db.collection(name).doc(ref.id).update({"id": ref.id});
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<List<TaskGroupResponse>> getList() async {
    try {
      QuerySnapshot snapshot = await db.collection(name).get();
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.map((doc) {
          return TaskGroupResponse.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  @override
  Future<void> deleteTaskGroup(String id) async {
    try {
      await db.collection(name).doc(id).delete();
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> updateTaskGroup(TaskGroupResponse taskGroupResponse) async {
    try {
      await db
          .collection(name)
          .doc(taskGroupResponse.id)
          .update(taskGroupResponse.toJson());
    } catch (e) {
      print(e);
    }
  }
}
