import 'dart:convert';
import 'dart:ui';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:musicPlayer/MisicPlayer/MusicPlayerScreen.dart';
import 'package:musicPlayer/modal/audio_url.dart';
import 'package:musicPlayer/modal/homeSongList.dart';
import 'package:musicPlayer/modal/playListResponse.dart';
import 'package:musicPlayer/modal/playListResponse.dart' as playList;
import 'package:musicPlayer/modal/player_song_list.dart';
import 'package:musicPlayer/screen/LoadingScreen/loadingScreen.dart';
import 'package:musicPlayer/widgets/gradientAppBar.dart';
import 'package:musicPlayer/widgets/songListItem.dart';
import 'package:page_transition/page_transition.dart';
import 'package:musicPlayer/network_utils/api.dart';
import 'package:http/http.dart' as http;
import 'package:progress_dialog/progress_dialog.dart';

class PlayListScreen extends StatefulWidget {
  final ItemsCollection itemsCollection;
  final String heroTag;
  const PlayListScreen({Key key, this.itemsCollection, this.heroTag})
      : super(key: key);
  @override
  _PlayListScreenState createState() => _PlayListScreenState();
}

class _PlayListScreenState extends State<PlayListScreen> {
  PlayListResponse playListResponse;
  bool _loading = true;
  AudioUrl audioUrl;
  List<NowPlayingClass> nowPlaying = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.itemsCollection.id);
    getlayListForId();
  }

  Future<void> sendSongUrlToPlayer(playList.Track track) async {
    print("IN FFF");
    Flushbar(
      title: "Loading...",
      message: track.title,
      reverseAnimationCurve: Curves.easeIn,
      forwardAnimationCurve: Curves.easeInOut,
      duration: Duration(seconds: 2),
      margin: EdgeInsets.all(8),
      borderRadius: 8,
    )..show(context);

    ProgressDialog pr = ProgressDialog(context);

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
          await Network().getStremUrl(track.media.transcodings[1].url);
      print(response.body);
      if (response.statusCode == 200) {
        var singerName = "UnKnow";
        if (track.user.fullName != null) {
          singerName = track.user.username;
        }
        var resBody = json.decode(response.body);
        audioUrl = new AudioUrl.fromJson(resBody);
        nowPlaying.add(new NowPlayingClass(
            audioUrl.url,
            track.title,
            singerName,
            track.artworkUrl,
            null,
            Duration(milliseconds: track.media.transcodings[1].duration)));
        pr.hide();
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: BGAudioPlayerScreen(
                    nowPlayingClass: nowPlaying, track: track)));
        Future.delayed(const Duration(milliseconds: 500), () {
          nowPlaying.clear();
        });
      }
    } catch (e) {
      print("Error");
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

  Future<void> getlayListForId() async {
    try {
      http.Response response =
          await Network().getPlayListForId(widget.itemsCollection.id);
      // print(response.body);
      if (response.statusCode == 200) {
        var resBody = json.decode(response.body);
        playListResponse = new PlayListResponse.fromJson(resBody);
        setState(() {
          _loading = false;
        });
      }
    } catch (e) {
      print("Error");
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
      body: _loading
          ? Center(
              child: Center(
                child: new LoadingScreen(),
              ),
            )
          : CustomScrollView(
              slivers: <Widget>[
                GardeenAppBar(
                  isProfile: false,
                  imageUrl: playListResponse.artworkUrl != null
                      ? playListResponse.artworkUrl
                          .replaceAll("large", "t500x500")
                      : "",
                  title: widget.itemsCollection.title,
                ),
                SliverToBoxAdapter(
                    child: SizedBox(
                  height: 16,
                )),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    playList.Track track = playListResponse.tracks[index];
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 4.0),
                          child: SongListItem(
                              // onClick: sendSongUrlToPlayer,
                              onClick: () {
                                print("OUTT");
                                sendSongUrlToPlayer(track);
                              },
                              imageUrl: track.artworkUrl != null
                                  ? track.artworkUrl
                                  : playListResponse.artworkUrl != null
                                      ? playListResponse.artworkUrl
                                      : "",
                              title: track.title != null
                                  ? track.title
                                  : "Title Not Avalive",
                              subtitle: track.user != null
                                  ? track.user.username != null
                                      ? track.user.username
                                      : ""
                                  : "Artise Name Not Found",
                              duration: track.media.transcodings[1].duration),
                        ),
                      ],
                    );
                  }, childCount: 5),
                ),
              ],
            ),
    );
  }
}
