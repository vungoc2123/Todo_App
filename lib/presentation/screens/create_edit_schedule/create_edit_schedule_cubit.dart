import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/application/enums/load_status.dart';
import 'package:todo/di.dart';
import 'package:todo/domain/models/response/schedule/event_response.dart';
import 'package:todo/domain/repositories/schedule/schedule_repository.dart';
import 'package:todo/presentation/screens/create_edit_schedule/create_edit_schedule_state.dart';

class CreateEditScheduleCubit extends Cubit<CreateEditScheduleState> {
  CreateEditScheduleCubit() : super(const CreateEditScheduleState());

  final _scheduleRepo = getIt<ScheduleRepository>();
  final _auth = FirebaseAuth.instance;

  void setEvent(EventResponse eventResponse) {
    emit(state.copyWith(eventResponse: eventResponse.copyWith(uId: _auth.currentUser?.uid)));
  }

  Future<void> createNewEvent() async {
    try{
      emit(state.copyWith(loadStatus: LoadStatus.loading));
      await _scheduleRepo.addNewEvent(state.eventResponse!);
      emit(state.copyWith(loadStatus: LoadStatus.success));
    }catch(e){
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }

  Future<void> updateEvent() async{
    try{
      emit(state.copyWith(loadStatus: LoadStatus.loading));
      await _scheduleRepo.updateEvent(state.eventResponse);
      emit(state.copyWith(loadStatus: LoadStatus.success));
    }catch(e){
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }
}
