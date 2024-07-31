import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/domain/models/response/schedule/event_response.dart';
import 'package:todo/domain/repositories/schedule/schedule_repository.dart';

class ScheduleRepositoryImpl extends ScheduleRepository {
  final db = FirebaseFirestore.instance;

  @override
  Future<void> addNewEvent(EventResponse newEvent) async {
    try {
      final ref = await db.collection("schedules").add(newEvent.toJson());
      await db.collection("schedules").doc(ref.id).update({"idEvent": ref.id});
    } catch (e) {
      throw ();
    }
  }
}
