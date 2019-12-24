import 'package:flutter/material.dart';
import 'package:message/routes/find_friends.dart';
import 'package:message/routes/home.dart';
import 'package:message/routes/login_screen.dart';
import 'package:message/routes/rootscreen.dart';
import 'package:message/routes/selection_screen.dart';
import 'package:message/routes/signup_screen.dart';
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
      theme:
          ThemeData.dark().copyWith(scaffoldBackgroundColor: Color(0xff27272d)),
      routes: {
        SelectScreen.id: (context) => SelectScreen(),
        Login.id: (context) => Login(),
        Home.id: (context) => Home(),
        RootScreen.id: (context) => RootScreen(),
        Signup.id: (context) => Signup(),
        FindFriends.id: (context) => FindFriends(),
      },
      initialRoute: RootScreen.id,
    );
  }
}
