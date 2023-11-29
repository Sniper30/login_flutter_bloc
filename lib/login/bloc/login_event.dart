part of 'login_bloc.dart';

sealed class LoginEvent {
  const LoginEvent();
}

class EmailChangeEvent extends LoginEvent {
  const EmailChangeEvent({required this.email});
  final String email;
}

class PasswordChangeEvent extends LoginEvent {
  const PasswordChangeEvent({required this.password});
  final String password;
}

class OnSubmitEvent extends LoginEvent {
  const OnSubmitEvent();
}
