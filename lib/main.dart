import 'dart:async';

import 'package:flutter/material.dart';
import 'package:message/routes/find_friends.dart';
import 'package:message/routes/home.dart';
import 'package:message/routes/login_screen.dart';
import 'package:message/routes/rootscreen.dart';
import 'package:message/routes/selection_screen.dart';
import 'package:message/routes/signup_screen_1.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:message/routes/temp/temp_state.dart';
import 'package:provider/provider.dart';

void main() {
  Crashlytics.instance.enableInDevMode = true;
  FlutterError.onError = Crashlytics.instance.recordFlutterError;
  runZoned(() {
    runApp(
      ChangeNotifierProvider(
        child: MyApp(),
        create: (context) => TempState(),
      ),
    );
  }, onError: Crashlytics.instance.recordError);
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
        SignUp.id: (context) => SignUp(),
        FindFriends.id: (context) => FindFriends(),
      },
      initialRoute: RootScreen.id,
    );
  }
}
