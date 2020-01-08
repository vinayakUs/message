// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';

// class ImageCapture extends StatefulWidget {
//   createState() => _ImageCaptureState();
// }

// class _ImageCaptureState extends State<ImageCapture> {
//   File _imageFile;

//   Future<void> _pickImage() async {
//     try {
//       await ImagePicker.pickImage(source: ImageSource.gallery)
//           .then((selected) async {
//         await ImageCropper.cropImage(
//           sourcePath: _imageFile.path,
//         ).then((cropped) {
//           setState(() {
//             _imageFile = cropped;
//           });
//         });
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

//   /// Remove image
//   void _clear() {
//     setState(() => _imageFile = null);
//   }

//   @override
//   void initState() {
//     super.initState();
//     _pickImage();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         // Select an image from the camera or gallery

//         // Preview the image and crop it
//         body: Column(
//       children: <Widget>[
//         FlatButton(
//           onPressed: () {
//             Navigator.pop(context, _imageFile);
//           },
//           child: Text(""),
//         ),
//       ],
//     ));
//   }
// }

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:message/models/constant.dart';

class ImageOperation {
  static uploadProfilePic(File file) async {
    File a;
    final FirebaseStorage _storage =
        FirebaseStorage(storageBucket: Constant.firebaseStoragebucket);
    _storage.ref().child("").putFile(a);
  }

  static Future<File> getImageFromGallery() async {
    File _selected = await ImagePicker.pickImage(source: ImageSource.gallery);
    File _cropped = await ImageCropper.cropImage(
      sourcePath: _selected.path,
      compressFormat: ImageCompressFormat.png,
      // compressQuality: 50,
      cropStyle: CropStyle.circle,
      // maxHeight: 320,
      // maxWidth: 320,
      aspectRatio: CropAspectRatio(ratioX: 20, ratioY: 20),
    );
    return _cropped;
  }
}
