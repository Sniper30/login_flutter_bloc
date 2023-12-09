import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_app/firebase_options.dart';
import 'package:login_app/services/user.service.dart';

class UserRepository {
  final UserServices _userServices = UserServices();

  Future<void> initializeFirebase() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
    } catch (e) {
      throw Exception(e.runtimeType);
    }
  }

  Future<void> register(String email, String password) async {
    await _userServices.register(email, password);
  }

  Future login(String email, String password) async {
    return await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }
}
