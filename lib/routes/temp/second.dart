import 'dart:io';
//import 'package:image_cropper/image_cropper.dart';

import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                  setState(
                    () {
                      _imageFile = val;
                    },
                  );
                  // ImageOperation.uploadProfilePic(_imageFile);
                });
              },
              // child:CircleAvatar(
              //   radius: 50,
              //   // child: _imageFile==null?Icon(Icons.satellite):Image.file(_imageFile),
              //   backgroundImage: _imageFile == null
              //       ? ExactAssetImage("")
              //       : Image.file(_imageFile),
              // ),
              child: new Container(
                width: 190.0,
                height: 190.0,
                decoration: new BoxDecoration(
                  shape: BoxShape.circle,
                  image: new DecorationImage(
                    fit: BoxFit.fill,
                    image: _imageFile == null
                        ? AssetImage("images/baseline_account_circle_black_18dp.png")
                        : FileImage(_imageFile),
                  ),
                ),
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
