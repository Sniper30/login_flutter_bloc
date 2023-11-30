import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/registration/bloc/registration_bloc.dart';
import 'package:login_app/repository/authentification_repository.dart';
import 'package:login_app/repository/user_repository.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  static Route route() {
    return MaterialPageRoute(builder: (_) => const Registration());
  }

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegistrationBloc(
        authentificationRepository:
            RepositoryProvider.of<AuthentificationRepository>(context),
        userRepository: UserRepository(),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Registration'),
        ),
        body: const FormRegistration(),
      ),
    );
  }
}

class FormRegistration extends StatelessWidget {
  const FormRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [InputEmail(), InputPassword(), SubmitButton()],
    );
  }
}

class InputEmail extends StatelessWidget {
  const InputEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        return TextField(
          onChanged: (value) => context
              .read<RegistrationBloc>()
              .add(EmailChangeEvent(email: value)),
        );
      },
    );
  }
}

class InputPassword extends StatelessWidget {
  const InputPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        return TextField(
          onChanged: (value) => context
              .read<RegistrationBloc>()
              .add(PasswordChangeEvent(password: value)),
        );
      },
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        return TextButton(
          child: const Text('register'),
          onPressed: () =>
              context.read<RegistrationBloc>().add(const OnSubmitEvent()),
        );
      },
    );
  }
}
