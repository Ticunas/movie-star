class LoginValidation {
  static bool isInvalidName(String? value) {
    if (value == null || value.isEmpty) {
      return true;
    }
    return false;
  }

  static bool isInvalidEmail(String? value) {
    if (value == null || !value.contains('@')) {
      return true;
    }
    return false;
  }
}
