part of 'authentification_bloc.dart';

sealed class AuthentificationEvent extends Equatable {
  const AuthentificationEvent();
}

class AuthentificationStatusChange extends AuthentificationEvent {
  const AuthentificationStatusChange({required this.status});
  final AuthentificationStatus status;

  @override
  List get props => [status];
}
