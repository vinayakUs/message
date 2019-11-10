class Validator{
  static bool validateNumber(String text) {
    Pattern pattern = r'^(\d{3})(\d{3})(\d{4})$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(text);
  }
  static bool validatePassword(String text) {
    Pattern pattern = r'^([\w\!@#$%^&*(),.?":{}|<>]+)$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(text);
  }

  static bool validateEmail(String text) {
    Pattern pattern = r'^([a-zA-Z\d\.-]+)@([a-zA-Z]+).([a-zA-Z]+)$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(text);
  }
}