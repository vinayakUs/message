import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:message/buisness/auth.dart';
import 'package:message/buisness/validator.dart';
import 'package:message/widget/custom_alert_dialog.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Login extends StatefulWidget {
  static String id = "Login";

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  VoidCallback onBackPressed;
  String email, password;
  bool loadingProgress=false;


  @override
  void initState() {
    super.initState();
    onBackPressed = () {
      Navigator.of(context).pop();
    };
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: SafeArea(
        child: Scaffold(
          body: SafeArea(
            child: ModalProgressHUD(
              inAsyncCall: loadingProgress,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        width: 300,
                        child: TextField(
                          onChanged: (value) {
                            email = value;
                          },
                        )),
                    Container(
                        width: 300,
                        child: TextField(
                          onChanged: (value) {
                            password = value;
                          },
                          obscureText: true,
                        )),
                    RaisedButton(
                      onPressed: () async {
                        _emailLogin(email, password);
                      },
                      child: Text("Login"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _emailLogin(String email, String password) async {
    setState(() {
      loadingProgress=true;
    });
    if (Validator.validateEmail(email) &&
        Validator.validatePassword(password)) {
      SystemChannels.textInput.invokeMethod("TextInput.hide");

      try {
        String user = await Auth.signIn(email, password);
        onBackPressed();
      } catch (e) {
        setState(() {
          loadingProgress=false;
        });
        String exception = Auth.getExceptionText(e);
        _showErrorAlert(
            title: "Signup failed",
            content: exception,
            onPressed: () {
              Navigator.pop(context);
            });
      }
    }
  }

  void _showErrorAlert(
      {String title, String content, VoidCallback onPressed}) async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          content: content,
          title: title,
          onPressed: onPressed,
        );
      },
    );
  }
}
