import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_app/repository/user_repository.dart';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:login_app/firebase_options.dart';

enum AuthentificationStatus { unknow, authentificated, unauthentificated }

class AuthentificationRepository extends UserRepository {
  final _controller = StreamController<AuthentificationStatus>();

  Stream<AuthentificationStatus> get status async* {
    yield AuthentificationStatus.unauthentificated;
    yield* _controller.stream;
  }

  @override
  login(String email, String password) async {
    try {
      await super.login(email, password);
      Future.delayed(const Duration(seconds: 1));
      _controller.add(AuthentificationStatus.authentificated);
    } on FirebaseException catch (e) {
      print('hay un error ${e.code}');
      _controller.add(AuthentificationStatus.unknow);
    }
  }

  @override
  Future? signout() async {
    await super.signout();
    Future.delayed(const Duration(seconds: 1));

    _controller.add(AuthentificationStatus.unknow);
    return;
  }
}
