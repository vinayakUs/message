import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:message/buisness/auth.dart';

class Home extends StatefulWidget {
  final FirebaseUser fireBaseUser;

  Home({this.fireBaseUser});

  static String id = "Home_screen";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.backspace),
              onPressed: () {
                Auth.signOut();
              },
            ),
            RaisedButton(
              onPressed: () async {
//                print(user.email);
              },
              child: Text(widget.fireBaseUser.email),
            ),
          ],
        ),
      ),
    );
  }
}
