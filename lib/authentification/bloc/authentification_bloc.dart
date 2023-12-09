import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_app/repository/authentification_repository.dart';
import 'package:login_app/repository/user_repository.dart';

part 'authentification_event.dart';
part 'authentification_state.dart';

class AuthentificationBloc
    extends Bloc<AuthentificationEvent, AuthentificationState> {
  final AuthentificationRepository _authentificationRepository;
  final UserRepository _userRepository;

  AuthentificationBloc(
      {required AuthentificationRepository authentificationRepository,
      required UserRepository userRepository})
      : _authentificationRepository = authentificationRepository,
        _userRepository = userRepository,
        super(const AuthentificationState()) {
    _authentificationRepository.status.listen(
      (status) => add(AuthentificationStatusChange(status: status)),
    );
    on<AuthentificationStatusChange>((event, emit) async {
      switch (event.status) {
        case AuthentificationStatus.unknow:
          return emit(AuthentificationState(status: event.status));
        case AuthentificationStatus.authentificated:
          return emit(AuthentificationState(status: event.status));
        case AuthentificationStatus.unauthentificated:
          return emit(AuthentificationState(status: event.status));
      }
    });
  }
}
