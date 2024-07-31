import 'package:equatable/equatable.dart';
import 'package:todo/application/enums/load_status.dart';

class LoginEmailState extends Equatable {
  final LoadStatus status;
  final String? userName;
  final String? password;
  final String? messenger;
  final String? errorUserName;
  final String? errorPassword;
  final bool isShowPass;

  const LoginEmailState(
      {this.status = LoadStatus.initial,
      this.messenger,
      this.errorPassword,
      this.errorUserName,
      this.password,
      this.userName,
      this.isShowPass = true});

  LoginEmailState copyWith(
      {LoadStatus? status,
      String? userName,
      String? password,
      String? messenger,
      String? errorUserName,
      String? errorPassword,
      bool? isShowPass}) {
    return LoginEmailState(
        status: status ?? this.status,
        messenger: messenger ?? this.messenger,
        userName: userName ?? this.userName,
        errorUserName: errorUserName ?? this.errorUserName,
        password: password ?? this.password,
        errorPassword: errorPassword ?? this.errorPassword,
        isShowPass: isShowPass ?? this.isShowPass);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        status,
        userName,
        password,
        messenger,
        errorPassword,
        errorUserName,
        isShowPass
      ];
}
