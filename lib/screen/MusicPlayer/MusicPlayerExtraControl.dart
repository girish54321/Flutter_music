import 'package:audio_service/audio_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:musicPlayer/database/dataBaseHelper/database_helper.dart';
import 'package:musicPlayer/helper/helper.dart';
import 'package:musicPlayer/modal/player_song_list.dart';
import 'package:musicPlayer/provider/Fav_list.dart';
import 'package:musicPlayer/screen/SingerProfile/singerProfile.dart';
import 'package:provider/provider.dart';
import 'package:like_button/like_button.dart';

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

  void _insert(MediaItem mediaItem, Function updateList) async {
    favSong
        .doc(FirebaseAuth.instance.currentUser.uid)
        .collection('userFav')
        .doc(mediaItem.extras['songId'].toString())
        .get()
        .then((doc) async {
      if (doc.exists) {
        doc.reference.delete();
        updateList();

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
            })
            .then((value) {})
            .catchError((error) => print("Failed to add user: $error"));

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
    allRows.forEach((row) => print(row));
  }

  void _delete(data, Function updateList) async {
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
    if (data.length == 0) {
      _insert(widget.mediaItem, updateList);
    } else {
      _delete(data, updateList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 33, right: 33, bottom: 14),
        child: Consumer<FavListProvider>(
          builder: (context, favListProvider, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LikeButton(
                    isLiked: addedFav,
                    onTap: (bool isLiked) async {
                      _insert(widget.mediaItem, favListProvider.updateList);
                      return !isLiked;
                    },
                    circleColor: CircleColor(
                        start: Theme.of(context).accentColor,
                        end: Theme.of(context).accentColor),
                    bubblesColor: BubblesColor(
                      dotPrimaryColor: Colors.grey,
                      dotSecondaryColor: Colors.grey,
                    ),
                    likeBuilder: (bool addedFav) {
                      return Icon(
                        Icons.favorite,
                        color: addedFav
                            ? Theme.of(context).accentColor
                            : Colors.grey,
                      );
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
                      Helper().goToPage(
                          context,
                          SingerProgile(nowPlayingClass: nowPlayingClass),
                          false);
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
