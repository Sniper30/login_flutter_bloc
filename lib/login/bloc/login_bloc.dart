import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:formz/formz.dart';
import 'package:login_app/repository/authentification_repository.dart';
import 'package:login_app/repository/user_repository.dart';
import 'package:login_app/services/models/formz.email.validation.dart';
import 'package:login_app/services/models/formz.password.validation.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthentificationRepository _authentificationRepository;
  final UserRepository _userRepository;
  LoginBloc({
    authentificationRepository = AuthentificationRepository,
    userRepository = UserRepository,
  })  : _authentificationRepository = authentificationRepository,
        _userRepository = userRepository,
        super(const LoginState()) {
    on<EmailChangeEvent>((event, emit) {
      final email = EmailInput.dirty(value: event.email);
      return emit(state.copyWith(
        email: EmailInput.dirty(value: event.email),
        isValid: Formz.validate([state.password, email]),
        status: FormzSubmissionStatus.initial,
      ));
    });
    on<PasswordChangeEvent>((event, emit) {
      final password = PasswordInput.dirty(value: event.password);
      return emit(state.copyWith(
          password: PasswordInput.dirty(value: event.password),
          isValid: Formz.validate([state.email, password]),
          status: FormzSubmissionStatus.initial));
    });
    on<OnSubmitEvent>(
      (event, emit) async {
        emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
        if (!state.isValid) {
          return emit(state.copyWith(status: FormzSubmissionStatus.failure));
        }
        try {
          final credentials = await _authentificationRepository.login(
              state.email.value, state.password.value);
          print(credentials);

          emit(state.copyWith(status: FormzSubmissionStatus.success));
        } catch (e) {
          return emit(state.copyWith(status: FormzSubmissionStatus.failure));
        }
      },
    );
  }
}
