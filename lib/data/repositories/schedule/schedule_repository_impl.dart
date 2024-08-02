import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/domain/models/response/schedule/event_response.dart';
import 'package:todo/domain/repositories/schedule/schedule_repository.dart';

class ScheduleRepositoryImpl extends ScheduleRepository {
  final db = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  @override
  Future<void> addNewEvent(EventResponse newEvent) async {
    try {
      final ref = await db.collection("schedules").add(newEvent.toJson());
      await db.collection("schedules").doc(ref.id).update({"idEvent": ref.id});
    } catch (e) {
      throw ();
    }
  }

  @override
  Future<List<EventResponse>> getEvents(String selectedDate) async {
    try {
      List<EventResponse> data = [];
      QuerySnapshot response = await db
          .collection('schedules')
          .where("date", isEqualTo: selectedDate)
          .where("uId", isEqualTo: auth.currentUser?.uid)
          .get();
      for (var x in response.docs) {
        data.add(EventResponse.fromJson(x.data() as Map<String, dynamic>));
      }
      return data;
    } catch (e) {
      throw ();
    }
  }

  @override
  Future<void> deleteEvent(String idEvent) async {
    try {
      await db.collection("schedules").doc(idEvent).delete();
    } catch (e) {
      throw ();
    }
  }

  @override
  Future<void> updateEvent(EventResponse event) async {
    try {
      await db
          .collection("schedules")
          .doc(event.idEvent)
          .update(event.toJson());
    } catch (e) {
      throw ();
    }
  }

  @override
  Future<void> tickDoneEvent(EventResponse event) async {
    try {
      await db
          .collection("schedules")
          .doc(event.idEvent)
          .update({"status": !event.status});
    } catch (e) {
      throw ();
    }
  }

  @override
  Future<List<EventResponse>> getAllEvent() async {
    try {
      List<EventResponse> data = [];
      QuerySnapshot response = await db
          .collection('schedules')
          .where("uId", isEqualTo: auth.currentUser?.uid)
          .get();
      for (var x in response.docs) {
        data.add(EventResponse.fromJson(x.data() as Map<String, dynamic>));
      }
      return data;
    } catch (e) {
      throw ();
    }
  }
}
