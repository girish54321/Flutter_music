import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musicPlayer/modal/user.dart';
import 'dart:math';

class LoginStateProvider with ChangeNotifier {
  bool logedIn = false;
  var userData;
  AppUser user;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference favSong =
      FirebaseFirestore.instance.collection('favSong');
  CollectionReference clientId =
      FirebaseFirestore.instance.collection('clientId');

  LoginStateProvider() {
    if (FirebaseAuth.instance.currentUser != null) {
      logedIn = true;
      notifyListeners();
      getUserData();
    } else {
      logedIn = false;
      notifyListeners();
    }
  }

  getClientId() {
    FirebaseFirestore.instance
        .collection('clientId')
        .doc('clientId')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        return true;
      } else {
        clientId.doc('clientId').set({
          'clientId': 'clientId',
        }).then((value) {
          logedIn = true;
          return true;
          // ignore: return_of_invalid_type_from_catch_error
        }).catchError((error) => print("Failed to add user: $error"));
      }
    });
  }

  saveUserFavSong() {
    var rng = new Random();
    favSong
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("userFav")
        .doc(rng.nextInt(100).toString())
        .set({"sing": "yeyeye"}).then((value) {
      logedIn = true;
    }).catchError((error) => print("Failed to add user: $error"));
  }

  getUserData() async {
    DocumentSnapshot doc =
        await users.doc(FirebaseAuth.instance.currentUser.uid).get();
    user = AppUser.fromDocument(doc);
    notifyListeners();
  }

  allDataFav() async {
    QuerySnapshot snapshot = await favSong
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('userFav')
        .get();
  }

  deleteFav() {
    favSong
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('userFav')
        .doc('206559958')
        .get()
        .then((doc) {
      if (doc.exists) {
        doc.reference.delete();
      }
    });
  }

  changeLoginState(bool state) {
    logedIn = state;
    if (state) {
      getUserData();
    }
    LoginStateProvider();
    notifyListeners();
  }

  Future<void> addUser(userId, userName, email, imageUrl) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        logedIn = true;
        notifyListeners();
        return true;
      } else {
        users.doc(userId).set({
          'userName': userName,
          'email': email,
          "imageUrl": imageUrl,
          'user_id': userId,
        }).then((value) {
          logedIn = true;
          notifyListeners();
          changeLoginState(true);
          return true;
          // ignore: return_of_invalid_type_from_catch_error
        }).catchError((error) => print("Failed to add user: $error"));
      }
    });
  }
}
