class CommonValidator {
  static passwdValidator(String? val) {
    if (val == null) return "Password is required";
    if (val.length < 6) return "Password length must be at least 6 Character";
    return null;
  }

  static String? emailValidator(String? val) {
    if (val == null || val.trim().isEmpty) {
      return "Email is required";
    }

    final emailRegex = RegExp(r'^[\w\.-]+@([\w-]+\.)+[a-zA-Z]{2,}$');

    if (!emailRegex.hasMatch(val.trim())) {
      return "Please enter a valid email address";
    }

    return null;
  }

  static reasonValidator(String? val) {
    if (val == null) return "Reason is required";
    if (val.isEmpty) return "Please enter a valid reason.";
    if (val.length < 6) return "Reason length must be at least 6 Character";
    return null;
  }

  static confirmPasswdValidator({required String? val, required String pass}) {
    if (val == null) return "Password is required";
    if (val.length < 6) return "Password length must be at least 6 Character";
    if (val != pass) return "Confirm password do not match with new Password";
    return null;
  }
}
