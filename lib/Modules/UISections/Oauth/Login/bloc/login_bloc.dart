import 'package:bloc/bloc.dart';
import 'package:weather_flutter/Modules/Service/AuthService/AuthService.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<EmailChanged>(_updateEmail);
    on<PasswordChanged>(_updatePassword);
    on<LoginWithEmailPass>(_login);
  }

  void _updateEmail(EmailChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _updatePassword(PasswordChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.password));
  }

  void _login(LoginWithEmailPass event, Emitter<LoginState> emit) async {
    emit(state.copyWith(state: LoginAPIState.loading));
    try {
      print('EMail = ${state.email}, password = ${state.password}');
      final login =
          await AuthService.shared.signInWithEmail(state.email, state.password);
      print('Login SUccess');
      emit(state.copyWith(
          state: LoginAPIState.success, message: 'Login Successful'));
    } catch (err) {
      print('Error = ${err.toString()}');
      emit(
          state.copyWith(state: LoginAPIState.failed, message: err.toString()));
    }
  }
}
