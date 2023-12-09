part of 'login_bloc.dart';

final class LoginState extends Equatable {
  const LoginState({
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
  });
  final EmailInput email;
  final PasswordInput password;
  final FormzSubmissionStatus status;
  final bool isValid;
  LoginState copyWith({
    EmailInput? email,
    PasswordInput? password,
    FormzSubmissionStatus? status,
    bool? isValid,
  }) {
    return LoginState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        isValid: isValid ?? this.isValid);
  }

  @override
  List<Object> get props => [email, password, status, isValid];
}
