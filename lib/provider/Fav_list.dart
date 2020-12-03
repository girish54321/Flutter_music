import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musicPlayer/database/data_modal/FavSongeMobileData.dart';

class FavListProvider with ChangeNotifier {
  List<FavSongMobileData> favSongMobileDataList = [];
  CollectionReference favSong =
      FirebaseFirestore.instance.collection('favSong');
  FavListProvider() {
    updateProviderData();
  }

  void updateList() {
    favSongMobileDataList.clear();
    updateProviderData();
  }

  void clearList() {
    print("CLINE LIST FAV");
    favSongMobileDataList = [];
    notifyListeners();
  }

  Future<void> updateProviderData() async {
    QuerySnapshot snapshot = await favSong
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('userFav')
        .get();

    for (int i = 0; i < snapshot.docs.length; i++) {
      FavSongMobileData favSongMobileData = new FavSongMobileData(
        int.parse(snapshot.docs[i]['trackid']),
        snapshot.docs[i]['transcodings'],
        snapshot.docs[i]['singerName'],
        snapshot.docs[i]['artworkUrl'],
        snapshot.docs[i]['duration'],
        snapshot.docs[i]['trackid'],
        snapshot.docs[i]['userid'],
        snapshot.docs[i]['avatarUrl'],
        snapshot.docs[i]['songname'],
      );

      favSongMobileDataList.add(favSongMobileData);
      notifyListeners();
    }
  }
}
