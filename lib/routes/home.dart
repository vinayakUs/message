import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:message/buisness/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:message/routes/find_friends.dart';

class Home extends StatefulWidget {
  final FirebaseUser fireBaseUser;

  Home({this.fireBaseUser});

  static String id = "Home_screen";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future getUserList;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(FontAwesomeIcons.userFriends),
                  onPressed: () {
                    Navigator.pushNamed(context, FindFriends.id);
                  },
                ),
                IconButton(
                  icon: Icon(FontAwesomeIcons.signOutAlt),
                  onPressed: () {
                    Auth.signOut();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
