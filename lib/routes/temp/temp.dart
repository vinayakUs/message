import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:message/buisness/auth.dart';
import 'package:message/buisness/validator.dart';
import 'package:message/models/user.dart';
import 'package:message/routes/temp/first.dart';
import 'package:message/routes/temp/second.dart';
import 'package:message/routes/temp/temp_state.dart';
import 'package:message/widget/custom_alert_dialog.dart';
import 'package:provider/provider.dart';

class TempScreen extends StatefulWidget {
  @override
  _TempScreenState createState() => _TempScreenState();
}

class _TempScreenState extends State<TempScreen> {
  bool loadingProgress = false;
  VoidCallback _onBackPressed;

  Future<bool> _checkUserNameExist(String username) async {
    bool _result = true;
    await Firestore.instance
        .collection('users')
        .where('username', isEqualTo: username)
        .getDocuments()
        .then((val) {
      if (val.documents.length == 0) {
        _result = false;
      }
    });
    return _result;
  }

  @override
  void initState() {
    super.initState();
    _onBackPressed = () {
      Navigator.pop(context);
    };
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TempState>(context, listen: false).updateFirstScreen(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Provider.of<TempState>(context, listen: true).firstScreen
                ? First(context)
                : Second(),
            RaisedButton(
              onPressed: Provider.of<TempState>(context, listen: true)
                      .firstScreen
                  ? () async {
                      bool _result = await _signUpCredentials();
                      if (_result == true) {
                        setState(() {
                          Provider.of<TempState>(context, listen: false)
                              .updateFirstScreen(false);
                        });
                      }
                    }
                  : () async {
                      if (!Validator.isemptyandnull([
                        Provider.of<TempState>(context, listen: false).username,
                        Provider.of<TempState>(context, listen: false).name
                      ])) {
                        await _checkUserNameExist(
                                Provider.of<TempState>(context, listen: false)
                                    .username)
                            .then((val) async {
                          if (val == false) {
                            await FirebaseAuth.instance.currentUser().then(
                              (val) async {
                                Auth.addUser(new User(
                                    userID: val.uid,
                                    email: val.email,
                                    firstName: Provider.of<TempState>(context,
                                            listen: false)
                                        .name,
                                    profilePictureURL: '',
                                    username: Provider.of<TempState>(context,
                                            listen: false)
                                        .username));
                                _onBackPressed();
                              },
                            );
                          } else {
                            _showErrorAlert(
                              title: "Check data",
                              content: "UserName already exist",
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            );
                          }
                        });
                      }
                    },
              child: Provider.of<TempState>(context, listen: true).firstScreen
                  ? Text("Next")
                  : Text("Finish"),
            )
          ],
        )),
      ),
    );
  }

  Future<bool> _signUpCredentials() async {
    bool _result;
    String email = Provider.of<TempState>(context, listen: false).email;
    String password = Provider.of<TempState>(context, listen: false).password;

    try {
      if (Validator.validateEmail(email) &&
          Validator.validatePassword(password)) {
        SystemChannels.textInput.invokeMethod("TextInput.hide");

        try {
          await Auth.signUp(email, password);
          _result = true;
        } catch (e) {
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
        throw Exception("Invalid Argument");
      }
    } catch (e) {
      _showErrorAlert(
        title: "check data",
        content: e.message,
        onPressed: () {
          Navigator.pop(context);
        },
      );
    }
    return _result;
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
