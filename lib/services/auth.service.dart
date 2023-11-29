import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_app/repository/authentification_repository.dart';

class AuthService {
  Future<void> register(String email, String password) async {
    final user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    print(user);
  }
}
