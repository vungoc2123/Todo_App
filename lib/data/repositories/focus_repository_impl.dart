import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/domain/models/response/focus/focus_response.dart';
import 'package:todo/domain/repositories/focus_repository.dart';

class FocusRepositoryImpl implements FocusRepository {
  final db = FirebaseFirestore.instance;
  String name = "focus";

  @override
  Future<void> addFocus(FocusResponse focusResponse) async {
    try {
      final ref = await db.collection(name).add(focusResponse.toJson());
      await db.collection(name).doc(ref.id).update({"id": ref.id});
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<List<FocusResponse>> getList(String uid) async {
    try {
      QuerySnapshot snapshot = await db.collection(name).get();
      if (snapshot.docs.isNotEmpty) {
        return snapshot.docs.map((doc) {
          return FocusResponse.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }
}
