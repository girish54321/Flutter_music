import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:musicPlayer/MisicPlayer/MusicPlayerScreen.dart';
import 'package:musicPlayer/modal/audio_url.dart';
import 'package:musicPlayer/modal/homeSongList.dart';
import 'package:musicPlayer/modal/playListResponse.dart';
import 'package:musicPlayer/modal/playListResponse.dart' as playList;
import 'package:musicPlayer/modal/player_song_list.dart';
import 'package:musicPlayer/widgets/gradientAppBar.dart';
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
    // print("Heor Tag");
    // print(widget.heroTag);
  }

  Future<void> sendSongUrlToPlayer(playList.Track track) async {
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
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) =>
        //           BGAudioPlayerScreen(nowPlayingClass: nowPlaying),
        //     ));
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.bottomToTop,
                child: BGAudioPlayerScreen(
                    nowPlayingClass: nowPlaying, track: track)));
        await Future.delayed(Duration(seconds: 5));
        nowPlaying.clear();
      }
    } catch (e) {
      print("Error");
      pr.hide();
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
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? Center(
              child: Center(
                child: new CircularProgressIndicator(),
              ),
            )
          : CustomScrollView(
              slivers: <Widget>[
                // SliverAppBar(
                //   expandedHeight: 360,
                //   pinned: false,
                //   flexibleSpace: FlexibleSpaceBar(
                //     title: Text(widget.itemsCollection.title),
                //     background: Hero(
                //       tag: widget.heroTag,
                //       child: Image.network(
                //         playListResponse.artworkUrl
                //             .replaceAll("large", "t500x500"),
                //         fit: BoxFit.cover,
                //       ),
                //     ),
                //   ),
                // ),
                GardeenAppBar(
                  isProfile: false,
                  imageUrl: playListResponse.artworkUrl != null
                      ? playListResponse.artworkUrl
                          .replaceAll("large", "t500x500")
                      : "",
                  title: widget.itemsCollection.title,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    playList.Track track = playListResponse.tracks[index];
                    return Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                      child: ListTile(
                        onTap: () {
                          sendSongUrlToPlayer(track);
                          // if (track.media == null) {
                          //   if (track.media.transcodings[1].url != null) {
                          //     sendSongUrlToPlayer(track);
                          //   }
                          // }
                        },
                        leading: CircleAvatar(
                          radius: 24.0,
                          backgroundImage: track.artworkUrl != null
                              ? NetworkImage(track.artworkUrl)
                              : playListResponse.artworkUrl != null
                                  ? NetworkImage(playListResponse.artworkUrl)
                                  : NetworkImage(""),
                          backgroundColor: Colors.transparent,
                        ),
                        title: Text(
                          track.title != null
                              ? track.title
                              : "Title Not Avalive",
                          maxLines: 2,
                        ),
                        subtitle: Text(track.user != null
                            ? track.user.username != null
                                ? track.user.username
                                : ""
                            : "Artise Name Not Found"),
                        trailing: track.media != null
                            ? Text(Network().printDuration(Duration(
                                milliseconds:
                                    track.media.transcodings[1].duration)))
                            : Text(""),
                      ),
                    );
                  }, childCount: playListResponse.tracks.length),
                ),
              ],
            ),
    );
  }
}