import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:todo/application/enums/load_status.dart';
import 'package:todo/presentation/screens/update_user/bloc/update_user_state.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  UpdateUserCubit() : super(const UpdateUserState());

  final ImagePicker picker = ImagePicker();

  Future<void> getImageFormDevice(ImageSource source) async {
    try {
      emit(state.copyWith(status: LoadStatus.loading));
      final XFile? image = await picker.pickImage(source: source);
      if (image != null) {
        String fileName = image.name;
        Reference storageRef =
            FirebaseStorage.instance.ref().child('images/$fileName');
        UploadTask uploadTask = storageRef.putFile(File(image.path));

        TaskSnapshot storageSnapshot = await uploadTask;
        String downloadUrl = await storageSnapshot.ref.getDownloadURL();

        emit(state.copyWith(status: LoadStatus.success, photoUrl: downloadUrl));
      }
    } catch (e) {
      emit(state.copyWith(status: LoadStatus.failure));
    }
  }

  void getInfoUser(
      {required String photoUrl,
      required String userName,
      required String email}) {
    emit(state.copyWith(userName: userName, email: email, photoUrl: photoUrl));
  }

  Future<bool> requestPermissions() async {
    PermissionStatus cameraStatus = await Permission.camera.status;
    PermissionStatus storageStatus = await Permission.storage.status;

    if (cameraStatus.isGranted && storageStatus.isGranted) {
      return true;
    }
    if (cameraStatus.isDenied || storageStatus.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.camera,
        Permission.storage,
      ].request();

      if (statuses[Permission.camera]!.isGranted &&
          statuses[Permission.storage]!.isGranted) {
        return true;
      }
    }

    return false;
  }

  void changeUserName(String userName) {
    emit(state.copyWith(userName: userName));
  }

  Future<void> updateInfoUser() async {
    // final GoogleSignInAccount? googleUser = await GoogleSignIn().signInSilently();
    final userCredential = FirebaseAuth.instance;
    final user = userCredential.currentUser;

    if (user != null) {
      await user.updatePhotoURL(state.photoUrl);
      await user.updateDisplayName(state.userName);
    }
  }
}
