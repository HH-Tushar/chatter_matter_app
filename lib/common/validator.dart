class CommonValidator {
  static passwdValidator(String? val) {
    if (val == null) return "Password is required";
    if (val.length < 6) return "Password length must be at least 6 Character";
    return null;
  }

  static confirmPasswdValidator({required String? val, required String pass}) {
    if (val == null) return "Password is required";
    if (val.length < 6) return "Password length must be at least 6 Character";
    if (val != pass) return "Confirm password do not match with new Password";
    return null;
  }
}
