import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/application/constants/app_constants.dart';
import 'package:todo/application/enums/load_status.dart';
import 'package:todo/presentation/screens/login_email/bloc/login_email_state.dart';

class LoginEmailCubit extends Cubit<LoginEmailState>{
  LoginEmailCubit() : super(const LoginEmailState());

  Future<void> loginWithGmail() async {
    if(checkValidate()){
      try {
        emit(state.copyWith(status: LoadStatus.loading,));
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: state.userName ?? '',
            password: state.password ?? ''
        );

        if (credential.user != null){
          emit(state.copyWith(status: LoadStatus.success, messenger: "Đăng nhập thành công"));
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-credential') {
          emit(state.copyWith(status: LoadStatus.failure,messenger: 'Sai thông tin tài khoản'));
          return;
        }
        emit(state.copyWith(status: LoadStatus.failure,messenger: e.code));
      } catch (e){
        emit(state.copyWith(status: LoadStatus.failure,messenger: e.toString()));
      }
    }
  }

  void changeUserName(String userName){
    emit(state.copyWith(userName: userName));
  }
  void changePass(String pass){
    emit(state.copyWith(password: pass));
  }

  void isShowPass(){
    emit(state.copyWith(isShowPass: !state.isShowPass));
  }

  bool checkUserName(){
    if(state.userName == null || state.userName == ""){
      emit(state.copyWith(errorUserName: 'Không được để trống'));
      return false;
    }
    if(!AppConstants().emailRegExp.hasMatch(state.userName!)){
      emit(state.copyWith(errorUserName: 'Sai định dạng email'));
      return false;
    }
    emit(state.copyWith(errorUserName: ''));
    return true;
  }
  bool checkPass(){
    if(state.password == null || state.password == ""){
      emit(state.copyWith(errorPassword: 'Không được để trống'));
      return false;
    }
    if(!AppConstants().passwordRegExp.hasMatch(state.password!)){
      emit(state.copyWith(errorPassword: 'mật khẩu phải có ít nhất 6 ký tự, một chữ hoa và một chữ số'));
      return false;
    }
    emit(state.copyWith(errorPassword: ''));
    return true;
  }

  bool checkValidate(){
    return checkUserName() && checkPass();
  }
}