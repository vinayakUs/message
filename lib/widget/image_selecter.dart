import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:message/buisness/auth.dart';
import 'package:message/models/constant.dart';

class ImageOperation {
  static uploadProfilePic(File file) async {
    String uid = await Auth.getCurrentFireBaseUser();
    final FirebaseStorage _storage =
        FirebaseStorage(storageBucket: Constant.firebaseStoragebucket);
    _storage.ref().child("$uid").putFile(file);
  }

  static Future<File> getImageFromGallery() async {
    File _cropped;
    await ImagePicker.pickImage(source: ImageSource.gallery)
        .then((_selected) async {
      if (_selected != null) {
        _cropped = await ImageCropper.cropImage(
          sourcePath: _selected.path,
          compressFormat: ImageCompressFormat.png,
          // compressQuality: 50,
          cropStyle: CropStyle.circle,
          // maxHeight: 320,
          // maxWidth: 320,
          aspectRatio: CropAspectRatio(ratioX: 20, ratioY: 20),
        );
      }
    });

    return _cropped;
  }
}
