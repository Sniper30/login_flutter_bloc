import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:login_app/home/home.dart';
import 'package:login_app/login/bloc/login_bloc.dart';
import 'package:login_app/registration/registration.dart';
import 'package:login_app/repository/authentification_repository.dart';
import 'package:login_app/repository/user_repository.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  static Route route() {
    return MaterialPageRoute(builder: (_) => const LoginPage());
  }

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) => LoginBloc(
                authentificationRepository:
                    RepositoryProvider.of<AuthentificationRepository>(context),
                userRepository: UserRepository(),
              ),
          child: const Flex(
            direction: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[FormLogin()],
          )),
    );
  }
}

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
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
                const SnackBar(content: Text('Authentication In Progress')),
              );
          } else if (state.status.isSuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Authentication Success')),
              );
            Future.delayed(const Duration(seconds: 1));
            Navigator.of(context)
                .pushAndRemoveUntil(HomePage.route(), (route) => false);
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
                ButtonSubmit(),
                LinkToRegistrationPage()
              ],
            )));
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
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          prefixIcon: const Icon(Icons.email),
          labelText: 'Email',
          errorText: (!state.email.isValid && !state.status.isInitial)
              ? '${state.email.error}'
              : null,
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
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            prefixIcon: const Icon(Icons.password_outlined),
            labelText: 'Password',
            errorText: (!state.password.isValid && !state.status.isInitial)
                ? '${state.password.error}'
                : null,
          ),
          onChanged: (value) => context
              .read<LoginBloc>()
              .add(PasswordChangeEvent(password: value)),
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
          child: const Text('Sign In'),
          onPressed: () {
            print(state.status);
            return context.read<LoginBloc>().add(const OnSubmitEvent());
          },
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
        child: const Text('No registrated yer? Sign Up'));
  }
}
