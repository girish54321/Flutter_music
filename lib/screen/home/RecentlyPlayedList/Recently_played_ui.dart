import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:musicPlayer/database/data_modal/FavSongeMobileData.dart';
import 'package:musicPlayer/helper/helper.dart';
import 'package:musicPlayer/helper/playerHelper.dart';
import 'package:musicPlayer/modal/audio_url.dart';
import 'package:musicPlayer/modal/player_song_list.dart';
import 'package:musicPlayer/network_utils/api.dart';
import 'package:musicPlayer/provider/RecentlyPlayedProvider.dart';
import 'package:musicPlayer/screen/home/RecentlyPlayedList/Recently_played.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

// ignore: camel_case_types
class Recently_playedUI extends StatefulWidget {
  Recently_playedUI({Key key}) : super(key: key);

  @override
  _Recently_playedUIState createState() => _Recently_playedUIState();
}

// ignore: camel_case_types
class _Recently_playedUIState extends State<Recently_playedUI> {
  List<NowPlayingClass> nowPlaying = [];
  AudioUrl audioUrl;

  void clearNowPlaying() {
    nowPlaying.clear();
  }

  Future<void> sendSongUrlToPlayer(FavSongMobileData favSongMobileData) async {
    await Helper().showLoadingDilog(context).show();
    try {
      http.Response response =
          await Network().getStremUrl(favSongMobileData.transcodings);
      print(response.body);
      if (response.statusCode == 200) {
        var singerName = "UnKnow";
        if (favSongMobileData.singerName != null) {
          singerName = favSongMobileData.singerName;
        }
        var resBody = json.decode(response.body);
        audioUrl = new AudioUrl.fromJson(resBody);
        nowPlaying.add(
          new NowPlayingClass(
              audioUrl.url,
              favSongMobileData.songname,
              singerName,
              favSongMobileData.artworkUrl,
              null,
              Helper().parseDuration(favSongMobileData.duration),
              singerName,
              int.parse(favSongMobileData.trackId),
              int.parse(favSongMobileData.userId),
              favSongMobileData.avatarUrl,
              1,
              favSongMobileData.transcodings),
        );
        await Helper().showLoadingDilog(context).hide();
        PlayerHelper().playSong(nowPlaying, context, clearNowPlaying);
      }
    } catch (e) {
      await Helper().showLoadingDilog(context).hide();
      Helper().showSnackBar(e.toString(), "Error.", context, true);
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RecentlyPlayedProvider>(
      builder: (context, recentlyPlayedProvider, child) {
        return recentlyPlayedProvider.favSongMobileDataList.length != 0
            ? RecentlyPlayedList(
                favSongMobileDataList:
                    recentlyPlayedProvider.favSongMobileDataList,
                sendSongUrlToPlayer: sendSongUrlToPlayer)
            : Text("");
      },
    );
  }
}
