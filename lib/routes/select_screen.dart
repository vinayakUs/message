import 'package:flutter/material.dart';
import 'package:message/routes/signup.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'login.dart';

class Selectscreen extends StatefulWidget {
  static String id = "Selct_screen";

  @override
  _SelectscreenState createState() => _SelectscreenState();
}

class _SelectscreenState extends State<Selectscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Login.id);
                },
                child: Text("login"),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Signup.id);
                },
                child: Text("Signup"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
