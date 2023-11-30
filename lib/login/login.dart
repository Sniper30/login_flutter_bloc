import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/login/bloc/login_bloc.dart';
import 'package:login_app/registration/registration.dart';
import 'package:login_app/repository/authentification_repository.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route route() {
    return MaterialPageRoute(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: BlocProvider(
          create: (context) => LoginBloc(
              authentificationRepository:
                  RepositoryProvider.of<AuthentificationRepository>(context)),
          child: const FormLogin()),
    );
  }
}

class FormLogin extends StatelessWidget {
  const FormLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return const Column(
          children: [
            InputEmail(),
            InputPassword(),
            ButtonSubmit(),
            LinkToRegistrationPage()
          ],
        );
      },
    );
  }
}

class InputEmail extends StatelessWidget {
  const InputEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextField(
          onChanged: (value) =>
              context.read<LoginBloc>().add(EmailChangeEvent(email: value)),
        );
      },
    );
  }
}

class InputPassword extends StatelessWidget {
  const InputPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextField(
          onChanged: (value) =>
              context.read<LoginBloc>().add(EmailChangeEvent(email: value)),
        );
      },
    );
  }
}

class ButtonSubmit extends StatelessWidget {
  const ButtonSubmit({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextButton(
          child: const Text('login'),
          onPressed: () async =>
              context.read<LoginBloc>().add(const OnSubmitEvent()),
        );
      },
    );
  }
}

class LinkToRegistrationPage extends StatelessWidget {
  const LinkToRegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.of(context)
              .pushAndRemoveUntil(Registration.route(), (route) => false);
        },
        child: const Text('No registrated yer?'));
  }
}
