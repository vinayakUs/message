import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:message/buisness/getlocation.dart';
import 'package:message/buisness/validator.dart';
import 'package:message/models/maps.dart';
import 'package:message/models/user.dart';

enum authProblems { UserNotFound, PasswordNotValid, NetworkError, UnknownError }

class Auth {
  static checkUserDataExist(String uid) async {
    bool _result = false;
    await Firestore.instance
        .document(GetLocation.getUserMap(uid))
        .get()
        .then((value) {
      if (value.exists) {
        _result = true;
      }
    });

    return _result;
  }

  static Future<String> signUp(String email, String password) async {
    AuthResult authResult = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return authResult.user.uid;
  }

  static Future<String> signIn(String email, String password) async {
    AuthResult authResult = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return authResult.user.uid;
  }

  static Future<String> getCurrentFireBaseUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user.uid;
  }

  static String getExceptionText(Exception e) {
    if (e is PlatformException) {
      switch (e.message) {
        case 'Bad state: No element':
          return 'no user found';
          break;
        case 'There is no user record corresponding to this identifier. The user may have been deleted.':
          return 'User with this e-mail not found.';
          break;
        case 'The password is invalid or the user does not have a password.':
          return 'Invalid password.';
          break;
        case 'A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          return 'No internet connection.';
          break;
        case 'The email address is already in use by another account.':
          return 'Email address is already taken.';
          break;
        case 'The email address is badly formatted.':
          return 'Email badly formatted.';
          break;
        default:
          return 'Unknown error occured.';
      }
    } else {
      return 'Unknown error occured.';
    }
  }

  static Future<void> signOut() async {
    return FirebaseAuth.instance.signOut();
  }

  static void addUser(User user) async {
    await checkUserExist(user.userID, "users").then((value) {
      if (!value) {
        print("user ${user.firstName} ${user.email}");
        Firestore.instance
            .document("users/${user.userID}")
            .setData(user.toUserMap());
        Firestore.instance
            .document(GetLocation.getPeople(user.userID))
            .setData(CustomMaps.peopleMap([], []));
      } else {
        print("user ${user.firstName} ${user.email} exists");
      }
    });
  }

  static Future<bool> checkUserExist(String userID, String location) async {
    bool exists = false;
    try {
      await Firestore.instance.document("$location/$userID").get().then((doc) {
        if (doc.exists)
          exists = true;
        else
          exists = false;
      });
      return exists;
    } catch (e) {
      return false;
    }
  }

  static Future<QuerySnapshot> findFriends(String user) async {
    if (Validator.validateEmail(user)) {
      return await Firestore.instance
          .collection("users")
          .where('email', isEqualTo: user)
          .getDocuments();
    } else {
      return await Firestore.instance
          .collection("users")
          .where('username', isEqualTo: user)
          .getDocuments();
    }
  }

  static Future<Map<String, dynamic>> getDocumentData({String path}) async {
    Map<String, dynamic> map;
    await Firestore.instance.document(path).get().then((value) {
      map = value.data;
    });
    return map;
  }

  static void updateDataByUid({Map<String, dynamic> data, String path}) async {
    Firestore.instance.document(path).updateData(data);
  }
  //
//  static void updateDataByUid(
//      {String uid, Map<String, dynamic> data, String location}) async {
//    Firestore.instance.document("$location/$uid").updateData(data);
//  }
}
