import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musicPlayer/database/dataBaseHelper/Recently_played.dart';
import 'package:musicPlayer/modal/player_song_list.dart';

class DatabaseOperations {
  final dbHelper = RecentlyPlayedDatabaseHelper.instance;
  showToastMessage(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void insertRecentlyPlayed(NowPlayingClass nowPlayingClass) async {
    Map<String, dynamic> row = {
      RecentlyPlayedDatabaseHelper.transcodings: nowPlayingClass.audio_url,
      RecentlyPlayedDatabaseHelper.singerName: nowPlayingClass.artist,
      RecentlyPlayedDatabaseHelper.artworkUrl:
          nowPlayingClass.artUri.replaceAll("large", "t500x500"),
      RecentlyPlayedDatabaseHelper.duration:
          nowPlayingClass.duration.toString(),
      RecentlyPlayedDatabaseHelper.trackid: nowPlayingClass.songId.toString(),
      RecentlyPlayedDatabaseHelper.userid: nowPlayingClass.singerId.toString(),
      RecentlyPlayedDatabaseHelper.avatarUrl: nowPlayingClass.imageUrl,
      RecentlyPlayedDatabaseHelper.songname: nowPlayingClass.title,
    };
    final id = await dbHelper.insert(row);
  }
}
