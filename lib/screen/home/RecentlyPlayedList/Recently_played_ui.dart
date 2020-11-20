import 'dart:convert';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:musicPlayer/database/data_modal/FavSongeMobileData.dart';
import 'package:musicPlayer/helper/helper.dart';
import 'package:musicPlayer/modal/audio_url.dart';
import 'package:musicPlayer/modal/player_song_list.dart';
import 'package:musicPlayer/network_utils/api.dart';
import 'package:musicPlayer/provider/RecentlyPlayedProvider.dart';
import 'package:musicPlayer/screen/MusicPlayer/MusicPlayerScreen.dart';
import 'package:musicPlayer/screen/home/RecentlyPlayedList/Recently_played.dart';
import 'package:page_transition/page_transition.dart';
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
        if (AudioService.running) {
          if (nowPlaying != null) {
            var listItem = nowPlaying[0];
            Map<String, dynamic> nowPlayingSinger = {
              "name": listItem.name,
              "songId": listItem.songId,
              "singerId": listItem.singerId,
              "imageUrl": listItem.imageUrl.replaceAll("large", "t500x500"),
              "fav": listItem.fav,
              "audio_url": listItem.audio_url
            };

            MediaItem mediaItem = new MediaItem(
                id: listItem.url,
                title: listItem.title,
                artist: listItem.artist,
                artUri: listItem.artUri.replaceAll("large", "t500x500"),
                album: listItem.album,
                duration: listItem.duration,
                extras: nowPlayingSinger);

            Future.delayed(Duration(seconds: 5));
            await AudioService.addQueueItem(mediaItem);
            Helper().showSnackBar("Added To PlayList.", "Done.", context, true);
            await Future.delayed(Duration(seconds: 5));
            nowPlaying.clear();
          }
        } else {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: BGAudioPlayerScreen(
                    nowPlayingClass: nowPlaying,
                  )));
          await Future.delayed(Duration(seconds: 5));
          nowPlaying.clear();
        }
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
