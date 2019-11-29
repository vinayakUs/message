import 'package:flutter/material.dart';
import 'package:message/routes/find_friends.dart';
import 'package:message/routes/home.dart';
import 'package:message/routes/login.dart';
import 'package:message/routes/rootscreen.dart';
import 'package:message/routes/select_screen.dart';
import 'package:message/routes/signup.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

void main() {
  Crashlytics.instance.enableInDevMode = true;

// Pass all uncaught errors to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        Selectscreen.id: (context) => Selectscreen(),
        Login.id: (context) => Login(),
        Home.id: (context) => Home(),
        Rootscreen.id: (context) => Rootscreen(),
        Signup.id: (context) => Signup(),
        FindFriends.id: (context) => FindFriends(),
      },
      initialRoute: Rootscreen.id,
    );
  }
}
