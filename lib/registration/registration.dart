import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:login_app/login/login.dart';
import 'package:login_app/registration/bloc/registration_bloc.dart';
import 'package:login_app/repository/authentification_repository.dart';
import 'package:login_app/repository/user_repository.dart';

final controller = StreamController<bool>();

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
      child: const Scaffold(
        body: Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [FormRegistration()],
        ),
      ),
    );
  }
}

class FormRegistration extends StatefulWidget {
  const FormRegistration({super.key});
  @override
  State<FormRegistration> createState() => _FormRegistrationState();
}

class _FormRegistrationState extends State<FormRegistration> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Failure')),
            );
        } else if (state.status.isInProgress) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication In Pregress')),
            );
        } else if (state.status.isSuccess) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(content: Text('Authentication Success')),
            );
        }
      },
      child: const SizedBox(
        width: 290,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconApp(),
            InputEmail(),
            Padding(padding: EdgeInsets.all(10.00)),
            InputPassword(),
            Padding(padding: EdgeInsets.all(10.00)),
            SubmitButton(),
            LinkToLoginPage()
          ],
        ),
      ),
    );
  }
}

class InputTest extends StatefulWidget {
  const InputTest({super.key});

  @override
  State<InputTest> createState() => _InputTestState();
}

class _InputTestState extends State<InputTest> {
  @override
  Widget build(BuildContext context) {
    return const TextField();
  }
}

class InputEmail extends StatelessWidget {
  const InputEmail({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationBloc, RegistrationState>(
      builder: (context, state) {
        return TextField(
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.email_rounded),
              labelText: 'Email',
              error: (!state.email.isValid && !state.status.isInitial)
                  ? Text('${state.email.error}')
                  : null),
          onChanged: (value) {
            return context
                .read<RegistrationBloc>()
                .add(EmailChangeEvent(email: value));
          },
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
          obscureText: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.password_outlined),
            labelText: 'Password',
          ),
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
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          child: const Text('Sign Up'),
          onPressed: () =>
              context.read<RegistrationBloc>().add(const OnSubmitEvent()),
        );
      },
    );
  }
}

class LinkToLoginPage extends StatelessWidget {
  const LinkToLoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
          foregroundColor: Colors.black45,
        ),
        onPressed: () {
          Navigator.of(context)
              .pushAndRemoveUntil(LoginPage.route(), (route) => false);
        },
        child: const Text('already have an accont? Sign In'));
  }
}
