import 'package:equatable/equatable.dart';
import 'package:todo/application/enums/load_status.dart';

class SignUpState extends Equatable {
  final LoadStatus status;
  final String? userName;
  final String? password;
  final String? messenger;
  final String? errorUserName;
  final String? errorPassword;
  final String? confirmPass;
  final String? errorConfirm;
  final bool showPass;
  final bool showConfirmPass;

  const SignUpState({this.status = LoadStatus.initial,
    this.errorUserName,
    this.errorPassword,
    this.messenger,
    this.password,
    this.userName,
    this.confirmPass,
    this.errorConfirm,
    this.showPass = false,
    this.showConfirmPass = false});

  SignUpState copyWith({LoadStatus? status,
    String? userName,
    String? password,
    String? messenger,
    String? errorUserName,
    String? errorPassword,
    String? confirmPass,
    String? errorConfirm,
    bool? showPass,
    bool? showConfirmPass}) {
    return SignUpState(
        status: status ?? this.status,
        messenger: messenger ?? this.messenger,
        userName: userName ?? this.userName,
        errorUserName: errorUserName ?? this.errorUserName,
        password: password ?? this.password,
        errorPassword: errorPassword ?? this.errorPassword,
        confirmPass: confirmPass ?? this.confirmPass,
        errorConfirm: errorConfirm ?? this.errorConfirm,
        showPass: showPass ?? this.showPass,
        showConfirmPass: showConfirmPass ?? this.showConfirmPass);
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [
        status,
        userName,
        password,
        messenger,
        errorPassword,
        errorUserName,
        confirmPass,
        errorConfirm,
        showPass,
        showConfirmPass
      ];
}
