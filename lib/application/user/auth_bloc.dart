import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/api_handler.dart';
import 'auth_repo.dart';

class UserBloc extends ChangeNotifier {
  UserBloc() {
    retrieveUser();
  }

  User? user;

  final _authRepo = AuthRepo();

  void retrieveUser() {
    final data = FirebaseAuth.instance.currentUser;
    if (data != null) {
      user = user;
    }
    notifyListeners();
  }

  Future<Attempt<User>> login({
    required String email,
    required String password,
  }) async {
    final (data, error) = await _authRepo.loginWithEmail(
      email: email,
      password: password,
    );

    user = data;
    notifyListeners();
    return (data, error);
  }

  Future<Attempt<User>> register({
    required String email,
    required String password,
  }) async {
    final (data, error) = await _authRepo.registerWithEmail(
      email: email,
      password: password,
    );
    user = data;
    notifyListeners();
    return (data, error);
  }

  void loginWithGoogle() {}
  void loginWithApple() {}
}
