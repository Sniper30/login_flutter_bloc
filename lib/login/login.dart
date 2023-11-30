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
      body: BlocProvider(
          create: (context) => LoginBloc(
              authentificationRepository:
                  RepositoryProvider.of<AuthentificationRepository>(context)),
          child: const Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[FormLogin()],
          )),
    );
  }
}

class FormLogin extends StatelessWidget {
  const FormLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
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
                ButtonSubmit(),
                LinkToRegistrationPage()
              ],
            ));
      },
    );
  }
}

class IconApp extends StatelessWidget {
  const IconApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      width: 80,
      height: 200,
      child: const FlutterLogo(
        size: 50,
      ),
    );
  }
}

class InputEmail extends StatelessWidget {
  const InputEmail({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      return TextField(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.email),
          labelText: 'Email',
        ),
        onChanged: (value) {
          context.read<LoginBloc>().add(EmailChangeEvent(email: value));
        },
      );
    });
  }
}

class InputPassword extends StatelessWidget {
  const InputPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return TextField(
          obscureText: true,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: Icon(Icons.password_outlined),
            labelText: 'Password',
          ),
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
          style: TextButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
          ),
          child: const Text('Login'),
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
        style: TextButton.styleFrom(
          foregroundColor: Colors.black45,
        ),
        onPressed: () {
          Navigator.of(context)
              .pushAndRemoveUntil(Registration.route(), (route) => false);
        },
        child: const Text('No registrated yer?'));
  }
}
