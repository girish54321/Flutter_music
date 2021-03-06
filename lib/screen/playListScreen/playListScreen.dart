import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:musicPlayer/database/dataBaseHelper/database_helper.dart';
import 'package:musicPlayer/helper/helper.dart';
import 'package:musicPlayer/helper/playerHelper.dart';
import 'package:musicPlayer/modal/audio_url.dart';
import 'package:musicPlayer/modal/homeSongList.dart';
import 'package:musicPlayer/modal/playListResponse.dart';
import 'package:musicPlayer/modal/playListResponse.dart' as playList;
import 'package:musicPlayer/modal/player_song_list.dart';
import 'package:musicPlayer/provider/RecentlyPlayedProvider.dart';
import 'package:musicPlayer/screen/Empty%20Screen/loadingScreen.dart';
import 'package:musicPlayer/widgets/gradientAppBar.dart';
import 'package:musicPlayer/widgets/infoView.dart';
import 'package:musicPlayer/widgets/songListItem.dart';
import 'package:musicPlayer/network_utils/api.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

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
  final dbHelper = DatabaseHelper.instance;
  ScrollController _scrollController;
  String errorMessage;

  @override
  void initState() {
    super.initState();
    getlayListForId();
    _scrollController = new ScrollController();
    _scrollController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void clearNowPlaying() {
    nowPlaying.clear();
  }

  Future<void> sendSongUrlToPlayer(
      playList.Track track, Function updateList) async {
    nowPlaying.clear();
    await Helper().showLoadingDilog(context).show();
    final hasData = await dbHelper.hasData(track.id.toString());
    try {
      http.Response response =
          await Network().getStremUrl(track.media.transcodings[1].url);

      if (response.statusCode == 200) {
        var singerName = "";
        if (track.user.fullName != null) {
          singerName = track.user.username;
        }
        var resBody = json.decode(response.body);
        audioUrl = new AudioUrl.fromJson(resBody);
        nowPlaying.add(
          new NowPlayingClass(
              audioUrl.url,
              track.title,
              singerName,
              track.artworkUrl,
              null,
              Duration(milliseconds: track.media.transcodings[1].duration),
              singerName,
              track.id,
              track.user.id,
              track.user.avatarUrl,
              hasData == true ? 1 : 0,
              track.media.transcodings[1].url),
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

  Future<void> getlayListForId() async {
    setState(() {
      _loading = true;
      errorMessage = null;
    });
    try {
      http.Response response =
          await Network().getPlayListForId(widget.itemsCollection.id);
      if (response.statusCode == 200) {
        var resBody = json.decode(response.body);
        playListResponse = new PlayListResponse.fromJson(resBody);
        setState(() {
          _loading = false;
          errorMessage = null;
        });
      } else {
        setState(() {
          _loading = false;
          errorMessage = "Server Error";
        });
        Helper().showSnackBar("Server Error", "Error.", context, true);
        Navigator.pop(context);
      }
    } catch (e) {
      Helper().showSnackBar(e.toString(), "Error.", context, true);
      setState(() {
        _loading = false;
        errorMessage = e.toString();
      });
      Navigator.pop(context);
      Navigator.pop(context);
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _loading
            ? Center(
                child: new LoadingScreen(),
              )
            : errorMessage != null
                ? ErrorView(
                    errorMessage: errorMessage,
                    function: () {
                      getlayListForId();
                    },
                  )
                : Consumer<RecentlyPlayedProvider>(
                    builder: (context, recentlyPlayedProvider, child) {
                    return CustomScrollView(
                      controller: _scrollController,
                      slivers: <Widget>[
                        GardeenAppBar(
                          isProfile: false,
                          imageUrl: playListResponse.artworkUrl != null
                              ? playListResponse.artworkUrl
                                  .replaceAll("large", "t500x500")
                              : null,
                          title: widget.itemsCollection.title,
                        ),
                        SliverToBoxAdapter(
                            child: SizedBox(
                          height: 16,
                        )),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            playList.Track track =
                                playListResponse.tracks[index];
                            return Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 4.0),
                                  child: SongListItem(
                                      onClick: () {
                                        sendSongUrlToPlayer(track,
                                            recentlyPlayedProvider.updateList);
                                      },
                                      imageUrl: track.artworkUrl != null
                                          ? track.artworkUrl
                                          : playListResponse.artworkUrl != null
                                              ? playListResponse.artworkUrl
                                              : null,
                                      title: track.title != null
                                          ? track.title
                                          : "Title Not Avalive",
                                      subtitle: track.user != null
                                          ? track.user.username != null
                                              ? track.user.username
                                              : ""
                                          : "Artise Name Not Found",
                                      duration:
                                          track.media.transcodings[1].duration),
                                ),
                              ],
                            );
                          }, childCount: 5),
                        ),
                      ],
                    );
                  }));
  }
}
