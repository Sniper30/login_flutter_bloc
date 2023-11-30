import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/login/login.dart';
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

class FormRegistration extends StatelessWidget {
  const FormRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
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
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.email_rounded),
            labelText: 'Email',
          ),
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
          child: const Text('register'),
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
        child: const Text('already have an accont?'));
  }
}
