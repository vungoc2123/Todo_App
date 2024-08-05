import 'package:equatable/equatable.dart';

class UtilitiesState extends Equatable {
  final String userName;
  final String email;
  final String url;

  const UtilitiesState({this.userName = '', this.email = '', this.url = ''});

  UtilitiesState copyWith({String? userName, String? email, String? url}){
    return UtilitiesState(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      url: url ?? this.url
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [userName, email, url];
}