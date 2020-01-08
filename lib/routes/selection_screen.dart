import 'package:flutter/material.dart';
import 'package:message/routes/signup_screen_1.dart';
import 'package:message/routes/temp/temp.dart';
import 'package:message/widget/wideButton.dart';

import 'login_screen.dart';

class SelectScreen extends StatefulWidget {
  static String id = "Selct_screen";

  @override
  _SelectScreenState createState() => _SelectScreenState();
}

class _SelectScreenState extends State<SelectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                WideButton(
                  background: Colors.blue,
                  enabled: true,
                  onPressed: () {
                    Navigator.pushNamed(context, Login.id);
                  },
                  child: Text("login"),
                ),
                SizedBox(
                  height: 10,
                ),
                // WideButton(
                //   enabled: true,
                //   background: Theme.of(context).primaryColorLight,
                //   onPressed: () {
                //     Navigator.pushNamed(context, SignUp.id);
                //   },
                //   child: Text("Signup"),
                // ),
                WideButton(
                  enabled: true,
                  background: Theme.of(context).primaryColorLight,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TempScreen()));
                  },
                  child: Text("SignupTemp"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
