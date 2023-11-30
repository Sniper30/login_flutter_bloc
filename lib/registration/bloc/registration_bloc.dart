import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:login_app/repository/authentification_repository.dart';
import 'package:login_app/repository/user_repository.dart';
import 'package:login_app/services/models/formz.email.validation.dart';
import 'package:login_app/services/models/formz.password.validation.dart';

part 'registration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthentificationRepository _authentificationRepository;
  final UserRepository _userRepository;
  RegistrationBloc({
    authentificationRepository = AuthentificationRepository,
    userRepository = UserRepository,
  })  : _authentificationRepository = authentificationRepository,
        _userRepository = userRepository,
        super(const RegistrationState()) {
    on<EmailChangeEvent>((event, emit) {
      final email = EmailInput.dirty(value: event.email);
      emit(state.copyWith(
          email: email,
          isValid: Formz.validate([state.password, email]),
          status: FormzSubmissionStatus.initial));
    });
    on<PasswordChangeEvent>((event, emit) {
      final password = PasswordInput.dirty(value: event.password);
      emit(state.copyWith(
          password: password,
          isValid: Formz.validate([state.email, password]),
          status: FormzSubmissionStatus.initial));
    });
    on<OnSubmitEvent>((event, emit) async {
      emit(state.copyWith(status: FormzSubmissionStatus.inProgress));

      if (state.isValid) {
        await _userRepository.register(state.email.value, state.password.value);
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } else {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    });
  }
}
