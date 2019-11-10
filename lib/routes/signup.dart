import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:message/buisness/auth.dart';
import 'package:message/buisness/validator.dart';
import 'package:message/widget/custom_alert_dialog.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Signup extends StatefulWidget {
  static String id = "Signin";
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String email, password, name, username;
  bool loadingProgress = false;
  VoidCallback onBackPressed;
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
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: loadingProgress,
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: 300,
                      child: TextField(
                        decoration: InputDecoration(hintText: "Name"),
                        onChanged: (value) {
                          name = value;
                        },
                      )),
                  Container(
                      width: 300,
                      child: TextField(
                        decoration: InputDecoration(hintText: "Username"),
                        onChanged: (value) {
                          username = value;
                        },
                      )),
                  Container(
                      width: 300,
                      child: TextField(
                        decoration: InputDecoration(hintText: "email"),
                        onChanged: (value) {
                          email = value;
                        },
                      )),
                  Container(
                      width: 300,
                      child: TextField(
                        decoration: InputDecoration(hintText: "Password"),
                        onChanged: (value) {
                          password = value;
                        },
                        obscureText: true,
                      )),
                  RaisedButton(
                    onPressed: () async {
                      _signUp(email, password, context);
                    },
                    child: Text("Sign Up"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
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

  void _signUp(String email, String password, BuildContext context) async {
    setState(() {
      loadingProgress = true;
    });
    if (Validator.validateEmail(email) &&
        Validator.validatePassword(password)) {
      SystemChannels.textInput.invokeMethod("TextInput.hide");

      try {
        String user = await Auth.signUp(email, password);
        print(user);
        onBackPressed();
      } catch (e) {
        setState(() {
          loadingProgress = false;
        });
        String exception = Auth.getExceptionText(e);
        _showErrorAlert(
          title: "Signup failed",
          content: exception,
          onPressed: () {
            Navigator.pop(context);
          },
        );
      }
    } else {
      print("got an error");
      setState(() {
        loadingProgress = false;
      });
    }
  }
}
