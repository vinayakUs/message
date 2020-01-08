import 'package:flutter/cupertino.dart';

class TempState extends ChangeNotifier implements Listenable {
  bool _isFirstScreen = true;
  String _email = "";
  String _password = "";
  String _username;
  String _name;

  bool get firstScreen {
    return _isFirstScreen;
  }

  String get email {
    return _email;
  }

  String get password {
    return _password;
  }

  String get name {
    return _name;
  }

  String get username {
    return _username;
  }

  updateemail(String val) {
    _email = val;
    notifyListeners();
  }

  updatepassword(String val) {
    _password = val;
    notifyListeners();
  }

  updatename(String val) {
    _name = val;

    notifyListeners();
  }

  updateusername(String val) {
    _username = val;
    notifyListeners();
  }

  updateFirstScreen(bool val) {
    _isFirstScreen = val;
    notifyListeners();
  }
}
