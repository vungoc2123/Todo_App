import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/application/enums/load_status.dart';

class LoginState extends Equatable {
  final LoadStatus status;
  final UserCredential? userCredential;
  final String? messenger;

  const LoginState({this.status = LoadStatus.initial, this.userCredential, this.messenger});

  LoginState copyWith({LoadStatus? status, UserCredential? userCredential, String? messenger}) {
    return LoginState(
        status: status ?? this.status,
        userCredential: userCredential ?? this.userCredential,
        messenger: messenger ?? this.messenger
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [status, userCredential, messenger];
}
