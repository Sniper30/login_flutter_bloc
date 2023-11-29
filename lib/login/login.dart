import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/login/bloc/login_bloc.dart';
import 'package:login_app/repository/authentification_repository.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Route route() {
    return MaterialPageRoute(builder: (_) => const LoginPage());
  }

//RepositoryProvider.of<AuthentificationRepository>(context)
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
        return Column(
          children: [
            TextField(
              onChanged: (value) =>
                  context.read<LoginBloc>().add(EmailChangeEvent(email: value)),
            ),
            TextField(
              onChanged: (value) => context
                  .read<LoginBloc>()
                  .add(PasswordChangeEvent(password: value)),
            ),
            TextButton(
              child: const Text('login'),
              onPressed: () async =>
                  context.read<LoginBloc>().add(const OnSubmitEvent()),
            )
          ],
        );
      },
    );
  }
}

// class InputEmail extends StatelessWidget {
//   const InputEmail({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LoginBloc, LoginState>(
//       builder: (context, state) {
//         return TextField(
//           onChanged: (value) =>
//               context.read<LoginBloc>().add(EmailChangeEvent(email: value)),
//         );
//       },
//     );
//   }
// }

// class InputPassword extends StatelessWidget {
//   const InputPassword({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LoginBloc, LoginState>(
//       builder: (context, state) {
//         return 
//       },
//     );
//   }
// }

// class ButtonSubmit extends StatelessWidget {
//   const ButtonSubmit({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LoginBloc, LoginState>(
//       builder: (context, state) {
//         return 
//       },
//     );
//   }
// }

//text

// TextField(
//           onChanged: (value) =>
//               context.read<LoginBloc>().add(EmailChangeEvent(email: value)),
//         );

//text
// TextField(
//           onChanged: (value) => context
//               .read<LoginBloc>()
//               .add(PasswordChangeEvent(password: value)),
//         );

//button
// TextButton(
//           child: const Text('login'),
//           onPressed: () async =>
//               context.read<LoginBloc>().add(const OnSubmitEvent()),
//         )