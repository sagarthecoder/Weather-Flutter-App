import 'package:equatable/equatable.dart';

enum LoginAPIState {
  loading, failed, success, none
}

class LoginState extends Equatable {
  final String email;
  final String password;
  final LoginAPIState state;
  final String? message;
  const LoginState({this.email = "", this.password = "", this.state = LoginAPIState.none, this.message});

  LoginState copyWith({String? email, String? password, LoginAPIState? state, String? message}) {
    return LoginState(
        email: email ?? this.email, password: password ?? this.password, state: state ?? this.state, message: message ?? this.message);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [email, password];
}
