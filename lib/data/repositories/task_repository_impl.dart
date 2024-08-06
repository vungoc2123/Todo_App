import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/domain/models/response/task/task_response.dart';
import 'package:todo/domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final db = FirebaseFirestore.instance;
  String name = "task";

  @override
  Future<void> addTask(TaskResponse taskResponse) async {
    try {
      final ref = await db.collection(name).add(taskResponse.toJson());
      await db.collection(name).doc(ref.id).update({"id": ref.id});
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> deleteTask(String id) async {
    try {
      await db.collection(name).doc(id).delete();
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<void> updateTask(TaskResponse taskResponse) async {
    try {
      await db
          .collection(name)
          .doc(taskResponse.id)
          .update(taskResponse.toJson());
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<List<TaskResponse>> getList(
      {String? idCate, bool? status, bool? isTimeUpdatedShort}) async {
    try {
      late QuerySnapshot snapshot ;
      if(status != null){
        snapshot= await db
            .collection(name)
            .where('status', isEqualTo: status)
            .where('idCate', isEqualTo: idCate)
            .orderBy(isTimeUpdatedShort == true ? 'timeUpdate' : 'createAt',
            descending: true)
            .get();
      }else{
        snapshot= await db
            .collection(name)
            .where('idCate', isEqualTo: idCate)
            .get();
      }
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.map((doc) {
          return TaskResponse.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }
}
