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
          email: email, isValid: Formz.validate([state.password, email])));
    });
    on<PasswordChangeEvent>((event, emit) {
      final password = PasswordInput.dirty(value: event.password);
      emit(state.copyWith(
          password: password,
          isValid: Formz.validate([state.email, password])));
    });
    on<OnSubmitEvent>((event, emit) async {
      if (state.isValid) {
        await _userRepository.register(state.email.value, state.password.value);
      } else {
        print('no valid');
        print(state);
      }
    });
  }
}
