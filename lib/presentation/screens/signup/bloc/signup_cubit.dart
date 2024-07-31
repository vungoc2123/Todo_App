import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/application/constants/app_constants.dart';
import 'package:todo/application/enums/load_status.dart';
import 'package:todo/presentation/screens/signup/bloc/signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState());

  Future<void> signUpWithEmail() async {
    if(checkValidate()){
      try {
        emit(state.copyWith(status: LoadStatus.loading));
        final credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: state.userName ?? '',
          password: state.password ?? '',
        );
        if (credential.user != null) {
          emit(state.copyWith(
              status: LoadStatus.success, messenger: 'Register successfully'));
        }
      } on FirebaseAuthException catch (e) {
        emit(state.copyWith(status: LoadStatus.failure, messenger: e.code));
      } catch (e) {
        emit(state.copyWith(status: LoadStatus.failure, messenger: e.toString()));
      }
    }
  }

  // check username, password and confirm password.
  bool checkPass() {
    if (AppConstants().passwordRegExp.hasMatch(state.password ?? '')) {
      emit(state.copyWith(
          errorPassword: ''));
      return true;
    }
    emit(state.copyWith(
        errorPassword: 'Mật khẩu phải có 6 ký tự, một chữ hoa và một số'));
    return false;
  }

  bool checkConFirmPass() {
    if (state.password == state.confirmPass) {
      emit(state.copyWith(
          errorConfirm: ''));
      return true;
    }
    emit(state.copyWith(
        errorConfirm: 'Mật khẩu không trùng khớp'));
    return false;
  }

  bool checkUserName() {
    if(AppConstants().emailRegExp.hasMatch(state.userName ?? '')){
      emit(state.copyWith(
          errorUserName: ''));
      return true;
    }
    emit(state.copyWith(
        errorUserName: 'Không đúng định dạng email'));
    return false;
  }

  bool checkValidate(){
    return checkUserName() && checkPass() && checkConFirmPass();
  }

  // user write user name and password.
  void changeUserName(String userName) {
    emit(state.copyWith(userName: userName));
  }

  void changePassword(String pass) {
    emit(state.copyWith(password: pass));
  }

  void changeConfirmPassword(String passConFirm) {
    emit(state.copyWith(confirmPass: passConFirm));
  }

  // show pass

  void isShowPass(){
    emit(state.copyWith(showPass: !state.showPass));
  }

  void isShowConfirmPass(){
    emit(state.copyWith(showConfirmPass: !state.showConfirmPass));
  }
}