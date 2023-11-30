part of 'registration_bloc.dart';

final class RegistrationState extends Equatable {
  const RegistrationState(
      {this.email = const EmailInput.pure(),
      this.password = const PasswordInput.pure(),
      this.isValid = false});

  final EmailInput email;
  final PasswordInput password;
  final bool isValid;

  RegistrationState copyWith({
    EmailInput? email,
    PasswordInput? password,
    bool? isValid,
  }) {
    return RegistrationState(
        email: email ?? this.email,
        password: password ?? this.password,
        isValid: isValid ?? this.isValid);
  }

  @override
  List<Object> get props => [email, password];
}
