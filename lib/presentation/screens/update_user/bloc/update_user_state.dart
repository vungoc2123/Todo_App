import 'package:equatable/equatable.dart';
import 'package:todo/application/constants/app_constants.dart';
import 'package:todo/application/enums/load_status.dart';

class UpdateUserState extends Equatable {
  final String? userName;
  final String? email;
  final String photoUrl;
  final LoadStatus status;

  const UpdateUserState(
      {this.email, this.userName, this.photoUrl = AppConstants.defaultImage, this.status = LoadStatus
          .initial});

  UpdateUserState copyWith(
      {String? userName, String? email, String? photoUrl, LoadStatus? status}) {
    return UpdateUserState(
        photoUrl: photoUrl ?? this.photoUrl,
        status: status ?? this.status,
        email: email ?? this.email,
        userName: userName ?? this.userName);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, userName, email, photoUrl];
}