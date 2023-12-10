import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/authentification/bloc/authentification_bloc.dart';
import 'package:login_app/repository/authentification_repository.dart';
import 'package:login_app/repository/user_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route route() {
    return MaterialPageRoute(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home page')),
      body: const Column(
        children: [
          Text('HOME PAGE'),
          LogOutBotton(),
        ],
      ),
    );
  }
}

class LogOutBotton extends StatelessWidget {
  const LogOutBotton({super.key});
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.read<AuthentificationBloc>().add(SignOut());
      },
      child: const Text('Logout'),
    );
  }
}
