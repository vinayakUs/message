import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:message/routes/home.dart';
import 'package:message/routes/selection_screen.dart';

class Rootscreen extends StatefulWidget {
  static String id = "Root_screen";
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<Rootscreen> {
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return new Container(
            color: Colors.white,

          );
        } else {
          if (snapshot.hasData) {
            return new Home(
              fireBaseUser: snapshot.data,

            );
          } else {
            return Selectscreen();
          }
        }
      },
    );
  }
}
