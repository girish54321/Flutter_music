import 'dart:convert';
import 'package:audio_service/audio_service.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:musicPlayer/MisicPlayer/MusicPlayerScreen.dart';
import 'package:musicPlayer/database/data_modal/FavSongeMobileData.dart';
import 'package:musicPlayer/database/dataBaseHelper/Recently_played.dart';
import 'package:musicPlayer/home/RecentlyPlayedList/Recently_played.dart';
import 'package:musicPlayer/modal/SingerProfileModal.dart';
import 'package:musicPlayer/modal/SingerTrackModale.dart';
import 'package:musicPlayer/modal/audio_url.dart';
import 'package:musicPlayer/modal/player_song_list.dart';
import 'package:musicPlayer/network_utils/api.dart';
import 'package:musicPlayer/provider/RecentlyPlayedProvider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Recently_playedUI extends StatefulWidget {
  Recently_playedUI({Key key}) : super(key: key);

  @override
  _Recently_playedUIState createState() => _Recently_playedUIState();
}

class _Recently_playedUIState extends State<Recently_playedUI> {
  List<FavSongMobileData> favSongMobileDataList = [];
  SingerProfile singerProfile;
  bool _loading = true;
  SingerTracksModal singerTracksModal;
  List<SingerTracksModal> collection = [];
  String newPageRef = "";
  final dbHelper = RecentlyPlayedDatabaseHelper.instance;
  List<NowPlayingClass> nowPlaying = [];
  AudioUrl audioUrl;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getuserFavSongs();
  }

  getuserFavSongs() async {
    favSongMobileDataList.clear();
    setState(() {});
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    // allRows.forEach((row) => print(row));
    print(allRows[0]);
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
    } else {
      print('query all NO DATA:');
    }
  }

  Future<void> sendSongUrlToPlayer(FavSongMobileData favSongMobileData) async {
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
              Network().parseDuration(favSongMobileData.duration),
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
    // return RecentlyPlayedList(
    //     favSongMobileDataList: favSongMobileDataList,
    //     sendSongUrlToPlayer: sendSongUrlToPlayer);

    return Consumer<RecentlyPlayedProvider>(
      //            <--- MyModel Consumer
      builder: (context, recentlyPlayedProvider, child) {
        return recentlyPlayedProvider.favSongMobileDataList.length != 0
            ? RecentlyPlayedList(
                favSongMobileDataList:
                    recentlyPlayedProvider.favSongMobileDataList,
                sendSongUrlToPlayer: sendSongUrlToPlayer)
            : Text("Noting Played till now.");
      },
    );
  }
}
