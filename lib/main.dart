import 'dart:async';

import 'package:flutter/material.dart';
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
  runZoned<Future<void>>(() async {
    runApp(MyApp());
  }, onError: Crashlytics.instance.recordError);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        Selectscreen.id: (context) => Selectscreen(),
        Login.id: (context) => Login(),
        Home.id: (context) => Home(),
        Rootscreen.id: (context) => Rootscreen(),
        Signup.id: (context) => Signup(),
      },
      initialRoute: Rootscreen.id,
    );
  }
}
