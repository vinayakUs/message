import 'package:cloud_firestore/cloud_firestore.dart';

class Friends {
  static Future getFriendListbyId() async {
    await Firestore.instance.collection("users").getDocuments();
  }
}
