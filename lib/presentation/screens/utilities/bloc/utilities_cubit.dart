import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/presentation/screens/utilities/bloc/utilities_state.dart';

class UtilitiesCubit extends Cubit<UtilitiesState> {
  UtilitiesCubit() : super(const UtilitiesState());

  Future<void> getInfoUser() async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn().signInSilently();

    final userCredential = FirebaseAuth.instance;
    final user = userCredential.currentUser;

    if (googleUser != null) {
      final email = googleUser.email;
      final userName = googleUser.displayName;
      final photoUrl = googleUser.photoUrl;

      emit(state.copyWith(url: photoUrl, userName: userName, email: email));
      return;
    }

    if (user != null) {
      final email = user.email;
      final userName = user.displayName;
      final photoUrl = user.photoURL;

      emit(state.copyWith(url: photoUrl, userName: userName, email: email));
      return;
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    if (await GoogleSignIn().isSignedIn()) {
      await GoogleSignIn().signOut();
    }
  }
}
