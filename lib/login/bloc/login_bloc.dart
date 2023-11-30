import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:login_app/repository/authentification_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthentificationRepository _authentificationRepository;
  LoginBloc({authentificationRepository = AuthentificationRepository})
      : _authentificationRepository = authentificationRepository,
        super(const LoginState()) {
    on<EmailChangeEvent>((event, emit) {
      return emit(state.copyWith(email: event.email));
    });
    on<PasswordChangeEvent>((event, emit) {
      return emit(state.copyWith(password: event.password));
    });
    on<OnSubmitEvent>(
      (event, emit) async {
        await _authentificationRepository.logIn(
            username: state.email, password: state.password);
        return emit(state);
      },
    );
  }
}
