import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:message/buisness/validator.dart';
import 'package:message/models/user.dart';

enum authProblems { UserNotFound, PasswordNotValid, NetworkError, UnknownError }

class Auth {
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

  static Future<FirebaseUser> getCurrentFireBaseUser() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    return user;
  }

  static String getExceptionText(Exception e) {
    if (e is PlatformException) {
      switch (e.message) {
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
    await checkUserExist(user.userID).then((value) {
      if (!value) {
        print("user ${user.firstName} ${user.email}");
        Firestore.instance
            .document("users/${user.userID}")
            .setData(user.toUserMap());
      } else {
        print("user ${user.firstName} ${user.email} exists");
      }
    });
  }

  static Future<bool> checkUserExist(String userID) async {
    bool exists = false;
    try {
      await Firestore.instance.document("users/$userID").get().then((doc) {
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

  static Future<String> delayFuture(String user) async {
    await Future.delayed(Duration(seconds: 3));
    return user;
  }
}
