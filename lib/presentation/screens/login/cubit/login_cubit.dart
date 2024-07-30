import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/application/enums/load_status.dart';
import 'package:todo/presentation/screens/login/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit() : super(const LoginState());

  Future<void> signInWithGoogle() async {
    try{
      emit(state.copyWith(status: LoadStatus.loading));
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      emit(state.copyWith(status: LoadStatus.success, userCredential: userCredential, messenger: "login ${state.status}"));
    } on Exception catch (e) {
      emit(state.copyWith(status: LoadStatus.failure, messenger: e.toString()));
    }
  }
}