import 'package:flutter/material.dart';
import 'package:message/routes/signup_screen.dart';
import 'package:message/widget/circularButton.dart';
import 'package:message/widget/wideButton.dart';

import 'login_screen.dart';

class Selectscreen extends StatefulWidget {
  static String id = "Selct_screen";

  @override
  _SelectScreenState createState() => _SelectScreenState();
}

class _SelectScreenState extends State<Selectscreen> {
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
                WideButton(
                  enabled: true,
                  background: Theme.of(context).primaryColorLight,
                  onPressed: () {
                    Navigator.pushNamed(context, Signup.id);
                  },
                  child: Text("Signup"),
                ),
                Row(
                  children: <Widget>[
                    CircularButton(
                      onPressed:(){},
                      enabled: true,
                      radius: 1000,
                      child: Icon(Icons.error,size: 200,),

                    ),
                    FlatButton(
                      padding: EdgeInsets.all(0),
                      onPressed: (){},
                      child: Icon(Icons.satellite),

                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10000)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
