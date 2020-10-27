import 'dart:convert';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:musicPlayer/database/Recently_played.dart';
import 'package:musicPlayer/database/data_modal/Recently_played_modal.dart';
import 'package:musicPlayer/modal/player_song_list.dart';
// import 'package:shared_preferences/shared_preferences.dart';

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

  printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void insertRecentlyPlayed(NowPlayingClass nowPlayingClass) async {
    print(nowPlayingClass.audio_url);

    Map<String, dynamic> row = {
      RecentlyPlayedDatabaseHelper.transcodings: nowPlayingClass.audio_url,
      RecentlyPlayedDatabaseHelper.singerName: nowPlayingClass.artist,
      RecentlyPlayedDatabaseHelper.artworkUrl: nowPlayingClass.artUri,
      RecentlyPlayedDatabaseHelper.duration: nowPlayingClass.duration.toString(),
      RecentlyPlayedDatabaseHelper.trackid: nowPlayingClass.songId.toString(),
      RecentlyPlayedDatabaseHelper.userid: nowPlayingClass.singerId.toString(),
      RecentlyPlayedDatabaseHelper.avatarUrl: nowPlayingClass.imageUrl,
      RecentlyPlayedDatabaseHelper.songname: nowPlayingClass.title,
    };
    final id = await dbHelper.insert(row);
    print('insertRecentlyPlayed row id: $id');
  }
}
