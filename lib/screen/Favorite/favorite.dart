import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:musicPlayer/DatabaseOperations/DatabaseOperations.dart';
import 'package:musicPlayer/MisicPlayer/MusicPlayerScreen.dart';
import 'package:musicPlayer/animasions/rightToLeft.dart';
import 'package:musicPlayer/animasions/showUp.dart';
import 'package:musicPlayer/database/data_modal/FavSongeMobileData.dart';
import 'package:musicPlayer/database/dataBaseHelper/database_helper.dart';
import 'package:musicPlayer/modal/SingerProfileModal.dart';
import 'package:musicPlayer/modal/SingerTrackModale.dart';
import 'package:musicPlayer/modal/audio_url.dart';
import 'package:musicPlayer/modal/player_song_list.dart';
import 'package:musicPlayer/network_utils/api.dart';
import 'package:musicPlayer/provider/Fav_list.dart';
import 'package:musicPlayer/provider/RecentlyPlayedProvider.dart';
import 'package:musicPlayer/widgets/songListItem.dart';
import 'package:page_transition/page_transition.dart';
import 'package:progress_dialog/progress_dialog.dart';
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
  SingerProfile singerProfile;
  bool _loading = true;
  SingerTracksModal singerTracksModal;
  List<SingerTracksModal> collection = [];
  String newPageRef = "";
  //Test
  List myList;
  ScrollController _scrollController = ScrollController();
  int _currentMax = 10;
  bool _loadingMore = true;
  List<NowPlayingClass> nowPlaying = [];
  AudioUrl audioUrl;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getuserFavSongs();
  }

  getuserFavSongs() async {
    favSongMobileDataList.clear();
    setState(() {});
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    // allRows.forEach((row) => print(row));
    // print(allRows[0]);
    if (allRows.length != 0) {
      print(allRows[0]);
      // var jsonData = json.decode(allRows.toString());
      for (int i = 0; i < allRows.length; i++) {
        FavSongMobileData favSongMobileData = new FavSongMobileData(
          allRows[i]['id'],
          allRows[i]['transcodings'],
          allRows[i]['singerName'],
          allRows[i]['artworkUrl'],
          allRows[i]['duration'],
          allRows[i]['track_id'],
          allRows[i]['user_id'],
          allRows[i]['avatarUrl'],
          allRows[i]['songname'],
        );
        setState(() {
          favSongMobileDataList.add(favSongMobileData);
        });
      }

      // print(Duration(
      //     milliseconds:
      //         int.parse(double.parse(favSongMobileDataList[0].duration))));
      //0:04:25.350000
//       var d = Duration(days: 1, hours: 1, minutes: 33, microseconds: 500);
// d.toString();  // "25:33:00.000500"

      // var myDouble = parseDuration(favSongMobileDataList[0].duration);
      // // assert(myDouble is double);
      // print(myDouble); // 123.45
    } else {
      print('query all NO DATA:');
    }
  }

  Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }

  Future<void> sendSongUrlToPlayer(
      FavSongMobileData favSongMobileData, Function updateList) async {
    ProgressDialog pr = ProgressDialog(context);
    //For normal dialog
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: false);
    pr.style(
        message: 'Loading..',
        padding: EdgeInsets.all(16.0),
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: Container(
            padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
        elevation: 6.0,
        insetAnimCurve: Curves.easeInOut,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 19.0,
          fontWeight: FontWeight.w600,
        ));
    await pr.show();
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
              parseDuration(favSongMobileData.duration),
              singerName,
              int.parse(favSongMobileData.trackId),
              int.parse(favSongMobileData.userId),
              favSongMobileData.avatarUrl,
              1,
              favSongMobileData.transcodings),
        );
        pr.hide();
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
            // print(nowPlayingSinger);
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
            print("ADDEDEDED");
            DatabaseOperations().insertRecentlyPlayed(nowPlaying[0]);
            updateList();
            Flushbar(
              title: "Done.",
              message: "Added To PlayList.",
              backgroundColor: Theme.of(context).accentColor,
              reverseAnimationCurve: Curves.easeIn,
              forwardAnimationCurve: Curves.easeInOut,
              duration: Duration(seconds: 2),
              margin: EdgeInsets.all(8),
              borderRadius: 8,
            )..show(context);
            await Future.delayed(Duration(seconds: 5));
            nowPlaying.clear();
          }
        } else {
          DatabaseOperations().insertRecentlyPlayed(nowPlaying[0]);
          updateList();
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
      pr.hide();
      Flushbar(
        title: "Error.",
        message: e.toString(),
        reverseAnimationCurve: Curves.easeIn,
        forwardAnimationCurve: Curves.easeInOut,
        duration: Duration(seconds: 2),
        margin: EdgeInsets.all(8),
        borderRadius: 8,
      )..show(context);
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
              itemCount: favListProvider.favSongMobileDataList.length,
              itemBuilder: (BuildContext context, int index) {
                FavSongMobileData favSongMobileData =
                    favListProvider.favSongMobileDataList[index];
                return Consumer<FavListProvider>(
                  builder: (context, favListProvider, child) {
                    return ShowUp(
                      delay: 150,
                      child: SongListItem(
                        onClick: () {
                          sendSongUrlToPlayer(
                              favSongMobileData, favListProvider.updateList);
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
              });
        }));
  }
}
