import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String userid;
  final String email;
  final String imageUrl;
  final String userName;

  AppUser({
    this.userid,
    this.email,
    this.imageUrl,
    this.userName,
  });

  factory AppUser.fromDocument(DocumentSnapshot doc) {
    return AppUser(
      userid: doc['user_id'],
      email: doc['email'],
      imageUrl: doc['imageUrl'],
      userName: doc['userName'],
    );
  }
}
