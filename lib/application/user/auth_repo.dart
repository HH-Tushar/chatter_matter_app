import 'package:firebase_auth/firebase_auth.dart';

import '../../core/api_handler.dart';

class AuthRepo {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Register user with email + password + displayName
  Future<Attempt<User>> registerWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      // 1. Create Auth account
      final UserCredential credential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = credential.user;
      if (user == null) {
        return failed(Failure(title: "Unable to create profile"));
      }

      return success(user);
    } on FirebaseAuthException catch (e) {
      return failed(Failure(title: e.message));
    } catch (e) {
      return failed(Failure(title: "Unable to register"));
    }
  }
  ///
  ///

  /// Register user with email + password + displayName
  Future<Attempt<User>> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      // 1. Create Auth account
      final UserCredential credential = await _auth
          .signInWithEmailAndPassword (email: email, password: password);

      final user = credential.user;
      if (user == null) {
        return failed(Failure(title: "Unable to find user"));
      }

      return success(user);
    } on FirebaseAuthException catch (e) {
      return failed(Failure(title: e.message));
    } catch (e) {
      return failed(Failure(title: "Something went wrong"));
    }
  }




}
