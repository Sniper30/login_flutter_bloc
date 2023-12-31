import 'package:firebase_auth/firebase_auth.dart';

class UserServices {
  Future<void> register(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw Exception(e.runtimeType);
    }
  }

  Future<void> login(String email, String password) async {}
}
