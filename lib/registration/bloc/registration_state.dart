part of 'registration_bloc.dart';

final class RegistrationState extends Equatable {
  const RegistrationState(
      {this.email = const EmailInput.pure(),
      this.password = const PasswordInput.pure(),
      this.isValid = false,
      this.status = FormzSubmissionStatus.initial});

  final EmailInput email;
  final PasswordInput password;
  final bool isValid;
  final FormzSubmissionStatus status;

  RegistrationState copyWith(
      {EmailInput? email,
      PasswordInput? password,
      bool? isValid,
      FormzSubmissionStatus? status}) {
    return RegistrationState(
        email: email ?? this.email,
        password: password ?? this.password,
        isValid: isValid ?? this.isValid,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [email, password, status, isValid];
}
