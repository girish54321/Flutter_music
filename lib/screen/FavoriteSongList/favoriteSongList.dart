import 'dart:convert';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:musicPlayer/DatabaseOperations/DatabaseOperations.dart';
import 'package:musicPlayer/animasions/showUp.dart';
import 'package:musicPlayer/database/data_modal/FavSongeMobileData.dart';
import 'package:musicPlayer/database/dataBaseHelper/database_helper.dart';
import 'package:musicPlayer/helper/helper.dart';
import 'package:musicPlayer/modal/audio_url.dart';
import 'package:musicPlayer/modal/player_song_list.dart';
import 'package:musicPlayer/network_utils/api.dart';
import 'package:musicPlayer/provider/Fav_list.dart';
import 'package:musicPlayer/provider/RecentlyPlayedProvider.dart';
import 'package:musicPlayer/screen/MusicPlayer/MusicPlayerScreen.dart';
import 'package:musicPlayer/widgets/songListItem.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Favorite extends StatefulWidget {
  Favorite({Key key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  final dbHelper = DatabaseHelper.instance;
  List<FavSongMobileData> favSongMobileDataList = [];
  List<NowPlayingClass> nowPlaying = [];
  AudioUrl audioUrl;

  Future<void> sendSongUrlToPlayer(FavSongMobileData favSongMobileData,
      Function updateList, Function updateResentPlayList) async {
    await Helper().showLoadingDilog(context).show();
    try {
      http.Response response =
          await Network().getStremUrl(favSongMobileData.transcodings);
      if (response.statusCode == 200) {
        var singerName = "Unknown";
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
            await AudioService.addQueueItem(mediaItem);
            DatabaseOperations().insertRecentlyPlayed(nowPlaying[0]);
            updateList();
            updateResentPlayList();
            Helper()
                .showSnackBar("Added To PlayList.", "Done.", context, false);
            nowPlaying.clear();
          }
        } else {
          DatabaseOperations().insertRecentlyPlayed(nowPlaying[0]);
          updateList();
          updateResentPlayList();
          Helper().goToPage(
              context,
              BGAudioPlayerScreen(
                nowPlayingClass: nowPlaying,
              ),
              false);
          await Future.delayed(Duration(seconds: 3));
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite"),
      ),
      body: Consumer<FavListProvider>(
        builder: (context, favListProvider, child) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: favListProvider.favSongMobileDataList.length,
            itemBuilder: (BuildContext context, int index) {
              FavSongMobileData favSongMobileData =
                  favListProvider.favSongMobileDataList[index];
              return Consumer<RecentlyPlayedProvider>(
                builder: (context, recentlyPlayedProvide, child) {
                  return ShowUp(
                    delay: 150,
                    child: SongListItem(
                      onClick: () {
                        sendSongUrlToPlayer(
                            favSongMobileData,
                            favListProvider.updateList,
                            recentlyPlayedProvide.updateList);
                      },
                      imageUrl: favSongMobileData.artworkUrl,
                      title: favSongMobileData.songname != null
                          ? favSongMobileData.songname
                          : "Title Not Avalive",
                      subtitle: favSongMobileData.singerName,
                      durationString: favSongMobileData.duration,
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
