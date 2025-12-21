import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/api_handler.dart';
import '../model/user_model.dart';
import 'auth_repo.dart';

class UserBloc extends ChangeNotifier {
  UserBloc() {
    init();
  }

  User? user;
  AppUser? profile;
  bool isLoadingProfile = false;
  bool isLoadingNotification = false;
  bool isUpdatingPassword = false;

  final _authRepo = AuthRepo();

  void init() async {
    retrieveUser();
    await fetchProfile();
  }

  Future<bool> retrieveUser() async {
    try {
      final data = FirebaseAuth.instance.currentUser;

      final check = await fetchProfile();
      if (data != null && check != null) {
        user = user;
        notifyListeners();
        return true;
      } else {
        logout();
      }
      notifyListeners();
      return false;
    } catch (e) {
      notifyListeners();
      return false;
    }
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

  Future<AppUser?> fetchProfile() async {
    isLoadingProfile = true;
    notifyListeners();
    final (data, error) = await _authRepo.getProfile();
    profile = data;
    isLoadingProfile = false;
    notifyListeners();
    return data;
  }

  Future updateNotification(bool v) async {
    isLoadingNotification = true;
    notifyListeners();

    // attempt

    profile?.pushNotification = v;
    isLoadingNotification = false;
    notifyListeners();
  }

  Future<Attempt<String>> changePassword({
    required String newPassword,
    required String oldPassword,
  }) async {
    final (data, error) = await _authRepo.changePassword(
      newPass: newPassword,
      oldPass: oldPassword,
    );

    return (data, error);
  }

  Future<bool> forgatPassword({required String email}) async {
    return false;
  }

  Future<Attempt<String>> updateProfile({File? image, String? name}) async {
    final (data, error) = await _authRepo.updateProfile(
      name: name,
      image: image,
    );
    if (data != null) {
      profile = data;
      notifyListeners();
      return success("successfully Updated the profile");
    } else {
      return failed(error!);
    }
  }

  void logout() {
    _authRepo.logout();
  }

  void loginWithGoogle() {}
  void loginWithApple() {}
}
