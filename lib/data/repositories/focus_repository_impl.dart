import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/domain/models/response/focus/focus_response.dart';
import 'package:todo/domain/models/response/report_focus/report_focus.dart';
import 'package:todo/domain/repositories/focus_repository.dart';

class FocusRepositoryImpl implements FocusRepository {
  final db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
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
  Future<List<ReportFocus>> getReportFocus(List<String> dates) async {
    try {
      List<ReportFocus> data = [];
      for (var x in dates) {
        double totalTime = 0;
        QuerySnapshot snapshot = await db
            .collection(name)
            .where("uid", isEqualTo: _auth.currentUser?.uid)
            .where('dateTime', isEqualTo: x)
            .get();
        if (snapshot.docs.isNotEmpty) {
          final response = snapshot.docs.map((doc) {
            return FocusResponse.fromJson(doc.data() as Map<String, dynamic>);
          }).toList();
          for (var res in response) {
            totalTime += res.completedTime.ceil();
          }
          data.add(ReportFocus(date: x, time: totalTime/60));
        }
        else {
          data.add(ReportFocus(date: x));
        }
      }
      return data;
    } catch (e) {
      throw ();
    }
  }
}
