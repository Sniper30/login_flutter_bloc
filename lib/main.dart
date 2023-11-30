import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login_app/authentification/bloc/authentification_bloc.dart';

import 'package:login_app/home/home.dart';
import 'package:login_app/login/Login.dart';
import 'package:login_app/repository/authentification_repository.dart';
import 'package:login_app/repository/user_repository.dart';
import 'package:login_app/splash/splash_page.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AuthentificationRepository _authentificationRepository;
  late UserRepository _userRepository;

  @override
  void initState() {
    _authentificationRepository = AuthentificationRepository();
    _userRepository = UserRepository();
    _userRepository.initializeFirebase().then((value) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: _authentificationRepository,
        child: BlocProvider(
          create: (context) => AuthentificationBloc(
            authentificationRepository: _authentificationRepository,
            userRepository: _userRepository,
          ),
          child: const AppView(),
        ));
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthentificationBloc, AuthentificationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthentificationStatus.unknow:
                _navigator.pushAndRemoveUntil(
                    LoginPage.route(), (route) => false);
              case AuthentificationStatus.authentificated:
                _navigator.pushAndRemoveUntil(
                    HomePage.route(), (route) => false);
              case AuthentificationStatus.unauthentificated:
                _navigator.pushAndRemoveUntil(
                    LoginPage.route(), (route) => false);
                break;
              default:
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
