import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class EmailChanged extends LoginEvent {
  final String email;
  const EmailChanged({required this.email});
}

class PasswordChanged extends LoginEvent {
  final String password;
  const PasswordChanged({required this.password});
}

class LoginWithEmailPass extends LoginEvent {}
