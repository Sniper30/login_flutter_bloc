import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_app/repository/authentification_repository.dart';

part 'authentification_event.dart';
part 'authentification_state.dart';

class AuthentificationBloc
    extends Bloc<AuthentificationEvent, AuthentificationState> {
  final AuthentificationRepository _authentificationRepository;

  AuthentificationBloc(
      {required AuthentificationRepository authentificationRepository})
      : _authentificationRepository = authentificationRepository,
        super(const AuthentificationState()) {
    _authentificationRepository.status.listen(
      (status) => add(AuthentificationStatusChange(status: status)),
    );

    on<AuthentificationStatusChange>((event, emit) async {
      print('try');
      switch (event.status) {
        case AuthentificationStatus.unknow:
          print('no no pasas');
          return emit(AuthentificationState(status: event.status));
        case AuthentificationStatus.authentificated:
          print('tas burlado');
          return emit(AuthentificationState(status: event.status));
        case AuthentificationStatus.unauthentificated:
          print('no pasas');
          print(event.status);
          return emit(AuthentificationState(status: event.status));
      }
    });
  }
}
