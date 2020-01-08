import 'dart:io';
//import 'package:image_cropper/image_cropper.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:message/widget/builder.dart';
import 'package:message/widget/image_selecter.dart';
import 'temp_state.dart';
import 'package:provider/provider.dart';

class Second extends StatefulWidget {
  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  VoidCallback _onbackpressed;
  File _imageFile;

  @override
  void initState() {
    super.initState();
    _onbackpressed = () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    };
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onbackpressed,
      child: CustomWidgetBuilder(builder: (context) {
        return Column(
          children: <Widget>[
            GestureDetector(
              onTap: () async {
                await ImageOperation.getImageFromGallery().then((val) {
                  print(val.path);
                  setState(() {
                    _imageFile = val;
                  });
                });
              },
              child: CircleAvatar(
                radius: 50,
                backgroundImage: _imageFile == null
                    ? AssetImage("/lib/images/account_icon.svg")
                    : AssetImage("${_imageFile.path}"),
              ),
            ),
            Container(
              width: 300,
              child: TextField(
                decoration: InputDecoration(hintText: "Name"),
                onChanged: (value) {
                  Provider.of<TempState>(context, listen: false)
                      .updatename(value);
                },
              ),
            ),
            Container(
              width: 300,
              child: TextField(
                decoration: InputDecoration(hintText: "Username"),
                onChanged: (value) {
                  Provider.of<TempState>(context, listen: false)
                      .updateusername(value);
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
