class Validator {
  static bool validateNumber(String text) {
    Pattern pattern = r'^(\d{3})(\d{3})(\d{4})$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(text);
  }

  static bool validatePassword(String text) {
    Pattern pattern =
        r'^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\S+$).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(text);
  }

  static bool validateEmail(String text) {
    Pattern pattern = r'^([a-zA-Z\d\.-]+)@([a-zA-Z]+).([a-zA-Z]+)$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(text);
  }
  static bool emptyCheck(String str){
    bool type=true;
    if(str==""){
      type=false;
    }
    return type;
  }
  static bool emptyCheckArray(String str){
    bool type=true;
    if(str==""){
      type=false;
    }
    return type;
  }
}
