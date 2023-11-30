part of 'registration_bloc.dart';

sealed class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

class EmailChangeEvent extends RegistrationEvent {
  const EmailChangeEvent({required this.email});
  final String email;
}

class PasswordChangeEvent extends RegistrationEvent {
  const PasswordChangeEvent({required this.password});
  final String password;
}

class OnSubmitEvent extends RegistrationEvent {
  const OnSubmitEvent();
}
