import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musicPlayer/database/dataBaseHelper/database_helper.dart';
import 'package:musicPlayer/modal/player_song_list.dart';
import 'package:musicPlayer/provider/Fav_list.dart';
import 'package:musicPlayer/screen/SingerProfile/singerProfile.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class ExtrarContols extends StatefulWidget {
  final MediaItem mediaItem;
  ExtrarContols({Key key, this.mediaItem}) : super(key: key);

  @override
  _ExtrarContolsState createState() => _ExtrarContolsState();
}

class _ExtrarContolsState extends State<ExtrarContols> {
  final dbHelper = DatabaseHelper.instance;
  bool addedFav = false;
  CollectionReference favSong =
      FirebaseFirestore.instance.collection('favSong');
  @override
  void initState() {
    super.initState();
    favSong
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('userFav')
        .doc(widget.mediaItem.extras['songId'].toString())
        .get()
        .then((doc) async {
      if (doc.exists) {
        setState(() {
          addedFav = true;
        });
      } else {
        setState(() {
          addedFav = false;
        });
      }
    }).catchError((error) => print("Failed to add user: $error"));
  }

// Button onPressed methods

  void _insert(MediaItem mediaItem, Function updateList) async {
    // row to insert

    print(mediaItem.extras['songId'].toString());
    // return;
    favSong
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('userFav')
        .doc(mediaItem.extras['songId'].toString())
        .get()
        .then((doc) async {
      if (doc.exists) {
        doc.reference.delete();
        updateList();
        print("DATA IS DELTED");
        setState(() {
          addedFav = false;
        });
      } else {
        Map<String, dynamic> row = {
          DatabaseHelper.transcodings: mediaItem.extras['audio_url'],
          DatabaseHelper.singerName: mediaItem.artist,
          DatabaseHelper.artworkUrl: mediaItem.artUri,
          DatabaseHelper.duration: mediaItem.duration.toString(),
          DatabaseHelper.trackid: mediaItem.extras['songId'].toString(),
          DatabaseHelper.userid: mediaItem.extras['singerId'].toString(),
          DatabaseHelper.avatarUrl: mediaItem.extras['imageUrl'],
          DatabaseHelper.songname: mediaItem.title,
        };

        favSong
            .doc(FirebaseAuth.instance.currentUser.uid)
            .collection("userFav")
            .doc(mediaItem.extras['songId'].toString())
            .set({
          "transcodings": mediaItem.extras['audio_url'],
          "singerName": mediaItem.artist,
          "artworkUrl": mediaItem.artUri,
          "duration": mediaItem.duration.toString(),
          "trackid": mediaItem.extras['songId'].toString(),
          "userid": mediaItem.extras['singerId'].toString(),
          "avatarUrl": mediaItem.extras['imageUrl'],
          "songname": mediaItem.title,
        }).then((value) {
          print("Added FAVE BASE");
        }).catchError((error) => print("Failed to add user: $error"));

        final id = await dbHelper.insert(row);
        print('inserted row id: $id');
        setState(() {
          addedFav = true;
        });
        updateList();
      }
    });
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

  void _update() async {
    // row to update
    // Map<String, dynamic> row = {
    //   DatabaseHelper.columnId: 1,
    //   DatabaseHelper.columnName: 'Mary',
    //   DatabaseHelper.columnAge: 32
    // };
    // final rowsAffected = await dbHelper.update(row);
    // print('updated $rowsAffected row(s)');
  }

  void _delete(data, Function updateList) async {
    // Assuming that the number of rows is the id for the last row.
    // final id = await dbHelper.queryRowCount();
    // final rowsDeleted = await dbHelper.delete(id);
    // print('deleted $rowsDeleted row(s): row $id');
    // print(data[0]['id']);
    // return;
    final rowsDeleted = await dbHelper.deleteFav(data[0]['id']);
    print('deleted $rowsDeleted ');
    setState(() {
      addedFav = false;
    });
    updateList();
  }

  Future<void> hasFav(Function updateList) async {
    final data = await dbHelper
        .findObjects22(widget.mediaItem.extras['songId'].toString());
    // return id;
    if (data.length == 0) {
      _insert(widget.mediaItem, updateList);
    } else {
      _delete(data, updateList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        // padding: EdgeInsets.symmetric(horizontal: 28),
        padding: EdgeInsets.only(left: 33, right: 33, bottom: 14),
        child: Consumer<FavListProvider>(
          //            <--- MyModel Consumer
          builder: (context, favListProvider, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: addedFav ? Colors.red : Colors.grey,
                    ),
                    onPressed: () async {
                      _insert(widget.mediaItem, favListProvider.updateList);
                    }),
                IconButton(
                    icon: Icon(
                      Icons.swap_horiz,
                    ),
                    onPressed: () {
                      _query();
                    }),
                IconButton(
                    icon: Icon(
                      Icons.account_circle,
                      color: Theme.of(context).accentColor,
                    ),
                    onPressed: () {
                      // imageUrl: https://i1.sndcdn.com/avatars-000463172286-f7nnhe-large.jpg, name: Distant.lo, fav: 1, songId: 25175318
                      // mediaItem.extras['imageUrl']
                      print("extras");
                      NowPlayingClass nowPlayingClass = new NowPlayingClass(
                        widget.mediaItem.id,
                        widget.mediaItem.title,
                        widget.mediaItem.artist,
                        widget.mediaItem.artUri,
                        null,
                        widget.mediaItem.duration,
                        widget.mediaItem.artist,
                        widget.mediaItem.extras['songId'],
                        widget.mediaItem.extras['singerId'],
                        widget.mediaItem.extras['imageUrl'],
                        widget.mediaItem.extras['fav'],
                        widget.mediaItem.extras['audio_url'],
                      );
                      print(widget.mediaItem.extras);
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.rightToLeft,
                              child: SingerProgile(
                                  nowPlayingClass: nowPlayingClass)));
                    }),
                IconButton(
                    icon: Icon(
                      Icons.queue_music,
                    ),
                    onPressed: () {})
              ],
            );
          },
        ));
  }
}
