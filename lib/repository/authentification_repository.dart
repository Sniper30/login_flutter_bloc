import 'dart:async';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:login_app/firebase_options.dart';

enum AuthentificationStatus { unknow, authentificated, unauthentificated }

class AuthentificationRepository {
  final _controller = StreamController<AuthentificationStatus>();

  // Future<void> initialize() async {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  // }

  Stream<AuthentificationStatus> get status async* {
    yield AuthentificationStatus.unauthentificated;
    yield* _controller.stream;
  }

  Future<void> logIn(
      {required String username, required String password}) async {
    // if (username == 'Sniper30' && password == '123') {
    await Future.delayed(const Duration(seconds: 1));
    return _controller.add(AuthentificationStatus.authentificated);
    //   return {username, password};
    // } else {
    //   _controller.add(AuthentificationStatus.unauthentificated);
    //   print(_controller.hasListener);

    //   return 'nada';
    // }
  }
}
