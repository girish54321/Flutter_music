import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musicPlayer/modal/user.dart';
import 'dart:math';

class LoginStateProvider with ChangeNotifier {
  bool logedIn = false;
  var userData;
  AppUser user = null;
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference favSong =
      FirebaseFirestore.instance.collection('favSong');

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

  saveUserFavSong() {
    //  favSong.document(widget.currentUser.id)
    //     .collection("userPosts")
    //     .document(postId)
    var rng = new Random();
    favSong
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection("userFav")
        .doc(rng.nextInt(100).toString())
        .set({"sing": "yeyeye"}).then((value) {
      logedIn = true;
      print("Added FAVE");
    }).catchError((error) => print("Failed to add user: $error"));
  }

  getUserData() async {
    // postsRef
    //     .document(widget.currentUser.id)
    //     .collection("userPosts")
    //     .document(postId)
    //     .setData({
    //   "postId": postId,
    //   "ownerId": widget.currentUser.id,
    //   "username": widget.currentUser.username,
    //   "mediaUrl": mediaUrl,
    //   "description": description,
    //   "location": location,
    //   "timestamp": timestamp,
    //   "likes": {},
    // });
    DocumentSnapshot doc =
        await users.doc(FirebaseAuth.instance.currentUser.uid).get();
    print("USER DATA");
    user = AppUser.fromDocument(doc);
    print(user.userName);
    notifyListeners();
  }

  allDataFav() async {
    QuerySnapshot snapshot = await favSong
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('userFav')
        .get();
    print("ALL NAV");
    // snapshot.docs.map((doc) => print(doc).toList());
    for (int i = 0; i < snapshot.docs.length; i++) {
      print("ALL NAV22");
      print(snapshot.docs[i]['sing']);
    }
    // print(snapshot.docs['sing']);
    // QuerySnapshot snapshot = await timelineRef
    //     .document(widget.currentUser.id)
    //     .collection('timelinePosts')
    //     .orderBy('timestamp', descending: true)
    //     .getDocuments();
    // List<Post> posts =
    //     snapshot.documents.map((doc) => Post.fromDocument(doc)).toList();
    // setState(() {
    //   this.posts = posts;
    // });
  }

  changeLoginState(bool state) {
    print("CHNECN USER");
    logedIn = state;
    notifyListeners();
  }

  // add user to dataBase

  Future<void> addUser(userId, userName, email) {
    print("ADDING USER");
    print(userId);
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database');
        logedIn = true;
        notifyListeners();
        return true;
      } else {
        users.doc(userId).set({
          'userName': userName,
          'email': email,
          "imageUrl": null,
          'user_id': userId,
        }).then((value) {
          logedIn = true;
          notifyListeners();
          print("Added");
          return true;
          changeLoginState(true);
        }).catchError((error) => print("Failed to add user: $error"));
      }
    });
  }
}
