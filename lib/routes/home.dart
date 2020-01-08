import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:message/buisness/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:message/routes/delete/im.dart';
import 'package:message/routes/find_friends.dart';
import 'package:message/routes/temp/second.dart';

class Home extends StatefulWidget {
  final FirebaseUser fireBaseUser;

  Home({this.fireBaseUser});

  static String id = "Home_screen";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future getUserList;
  File _file;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickImage() async {
    File selected = await ImagePicker.pickImage(source: ImageSource.gallery);
    // File cropped = await ImageCropper.cropImage(
    //   sourcePath: selected.path,
    // );
    setState(() {
      _file = selected;
    });
  }

  Future<void> _cropImage() async {
    try {
      File cropped = await ImageCropper.cropImage(
        sourcePath: _file.path,
        // ratioX: 1.0,
      );

      setState(() {
        _file = cropped;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
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
            GestureDetector(
              onTap: () {
                _pickImage();
              },
              child: _file == null ? Icon(Icons.ac_unit) : Image.file(_file),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ImageCapture()));
              },
            )
          ],
        ),
      ),
    );
  }
}
