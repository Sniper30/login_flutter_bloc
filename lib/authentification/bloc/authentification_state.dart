part of 'authentification_bloc.dart';

class AuthentificationState extends Equatable {
  const AuthentificationState({this.status = AuthentificationStatus.unknow});
  final AuthentificationStatus status;

  // AuthentificationState copyWith({final AuthentificationStatus? status}) {
  //   return AuthentificationState(status: status ?? this.status);
  // }

  @override
  List<Object> get props => [status];
}

final class AuthentificationInitial extends AuthentificationState {
  const AuthentificationInitial({status = AuthentificationStatus.unknow})
      : super(status: status);
}
