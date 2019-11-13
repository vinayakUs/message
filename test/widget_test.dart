import 'package:flutter_test/flutter_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  test("description", () async {
    await Firestore.instance
        .collection("users")
        .where('email', isEqualTo: "hdhdhd@gmail.com")
        .getDocuments();
    print("done");
  });
}
