import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musicPlayer/database/dataBaseHelper/database_helper.dart';
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

  Future<void> updateProviderData() async {
    // final dbHelper = DatabaseHelper.instance;
    // final allRows = await dbHelper.queryAllRows();
    // print('query all rows: PROVIDER');
    // // print(allRows[0]);
    // if (allRows.length != 0) {
    //   // print(allRows[0]);
    //   for (int i = 0; i < allRows.length; i++) {

    //   }
    //   notifyListeners();

    QuerySnapshot snapshot = await favSong
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('userFav')
        .get();
    print("ALL NAV");
    // snapshot.docs.map((doc) => print(doc).toList());
    for (int i = 0; i < snapshot.docs.length; i++) {
      print("ALL avatarUrl");
      // print(snapshot.docs[i]['singerName']);
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
        //  "transcodings": mediaItem.extras['audio_url'],
        //   "singerName": mediaItem.artist,
        //   "artworkUrl": mediaItem.artUri,
        //   "duration": mediaItem.duration.toString(),
        //   "trackid": mediaItem.extras['songId'].toString(),
        //   "userid": mediaItem.extras['singerId'].toString(),
        //   "avatarUrl": mediaItem.extras['imageUrl'],
        //   "songname": mediaItem.title,
      );

      favSongMobileDataList.add(favSongMobileData);
      notifyListeners();
    }
  }
}
