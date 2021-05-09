import 'dart:convert';
import 'package:audio_service/audio_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musicPlayer/DatabaseOperations/DatabaseOperations.dart';
import 'package:musicPlayer/helper/helper.dart';
import 'package:musicPlayer/modal/SingerProfileModal.dart';
import 'package:musicPlayer/modal/SingerTrackModale.dart';
import 'package:musicPlayer/modal/audio_url.dart';
import 'package:musicPlayer/modal/player_song_list.dart';
import 'package:musicPlayer/network_utils/api.dart';
import 'package:http/http.dart' as http;
import 'package:musicPlayer/screen/MusicPlayer/MusicPlayerScreen.dart';
import 'package:musicPlayer/screen/SingerProfile/singerProfileUi.dart';
import 'package:flutter/material.dart';

class SingerProgile extends StatefulWidget {
  final NowPlayingClass nowPlayingClass;

  const SingerProgile({Key key, this.nowPlayingClass}) : super(key: key);
  @override
  _SingerProgileState createState() => _SingerProgileState();
}

class _SingerProgileState extends State<SingerProgile> {
  SingerProfile singerProfile;
  bool _loading = true;
  SingerTracksModal singerTracksModal;
  List<SingerTracksModal> collection = [];
  String newPageRef = "";
  //Test
  List myList;
  ScrollController _scrollController = ScrollController();
  bool _loadingMore = true;
  List<NowPlayingClass> nowPlaying = [];
  AudioUrl audioUrl;
  String errorMessage;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      if (widget.nowPlayingClass != null) {
        getSingerProfile();
      } else {
        Fluttertoast.showToast(
            msg: "Error Loading Singer",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Theme.of(context).accentColor,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _getMoreData();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  _getMoreData() async {
    try {
      http.Response response = await Network().getMOreTracks(newPageRef);
      if (response.statusCode == 200) {
        var resBody = json.decode(response.body);
        setState(() {
          _loading = false;
        });
        setState(() {
          newPageRef = resBody['next_href'];
        });
        for (int i = 0; i <= resBody['collection'].length; i++) {
          Collection collectionModale =
              new Collection.fromJson(resBody['collection'][i]);
          setState(() {
            singerTracksModal.collection.add(collectionModale);
          });
        }
        print(resBody['collection'].length);
        if (resBody['collection'].length == 0) {
          _loadingMore = false;
        }
      }
    } catch (e) {
      Helper().showSnackBar(e.toString(), "Error.", context, true);
      _loadingMore = false;
      print(e);
    }
  }

  Future<void> getSingerProfile() async {
    setState(() {
      _loading = true;
      errorMessage = null;
    });
    var userId = widget.nowPlayingClass.singerId;
    try {
      http.Response response = await Network().getSingerProfile(userId);
      if (response.statusCode == 200) {
        var resBody = json.decode(response.body);
        setState(() {
          _loading = false;
          singerProfile = new SingerProfile.fromJson(resBody);
          errorMessage = null;
        });
        getSignerSonges(userId);
      } else {
        setState(() {
          _loading = false;
          errorMessage = "Error";
        });
      }
    } catch (e) {
      Helper().showSnackBar(e.toString(), "Error.", context, true);
      setState(() {
        _loading = false;
        errorMessage = e.toString();
      });
      print(e);
    }
  }

  Future<void> getSignerSonges(userId) async {
    try {
      http.Response response = await Network().getAllTrackFormSinger(userId);
      if (response.statusCode == 200) {
        var resBody = json.decode(response.body);
        setState(() {
          _loading = false;
        });
        setState(() {
          singerTracksModal = new SingerTracksModal.fromJson(resBody);
        });
        setState(() {
          newPageRef = singerTracksModal.nextHref;
        });
      }
    } catch (e) {
      print("Error");
      Helper().showSnackBar(e.toString(), "Error.", context, true);
      print(e);
    }
  }

  Future<void> sendSongUrlToPlayer(
      Collection collection, Function updateList) async {
    await Helper().showLoadingDilog(context).show();
    try {
      http.Response response =
          await Network().getStremUrl(collection.media.transcodings[1].url);
      print(response.body);
      if (response.statusCode == 200) {
        var singerName = "UnKnow";
        if (collection.user.fullName != null) {
          singerName = collection.user.username;
        }
        var resBody = json.decode(response.body);
        audioUrl = new AudioUrl.fromJson(resBody);
        nowPlaying.add(
          new NowPlayingClass(
              audioUrl.url,
              collection.title,
              singerName,
              collection.artworkUrl,
              null,
              Duration(milliseconds: collection.media.transcodings[1].duration),
              singerName,
              collection.id,
              collection.user.id,
              collection.user.avatarUrl,
              1,
              collection.media.transcodings[1].url),
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

            Future.delayed(Duration(seconds: 3));
            await AudioService.addQueueItem(mediaItem);
            DatabaseOperations().insertRecentlyPlayed(nowPlaying[0]);
            updateList();
            await Helper().showLoadingDilog(context).hide();
            Helper()
                .showSnackBar("Added To PlayList.", "Done.", context, false);
            await Future.delayed(Duration(seconds: 2));
            nowPlaying.clear();
          }
        } else {
          await Helper().showLoadingDilog(context).hide();
          DatabaseOperations().insertRecentlyPlayed(nowPlaying[0]);
          updateList();
          Helper().goToPage(
              context,
              BGAudioPlayerScreen(
                nowPlayingClass: nowPlaying,
              ));
          await Future.delayed(Duration(seconds: 1));
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
    return SingerProfileUi(
      avatarUrl:
          widget.nowPlayingClass.imageUrl.replaceAll("large", "t500x500"),
      loading: _loading,
      loadingMore: _loadingMore,
      scrollController: _scrollController,
      singerProfile: singerProfile,
      singerTracksModal: singerTracksModal,
      sendSongUrlToPlayer: sendSongUrlToPlayer,
      errorMessage: errorMessage,
      getSingerProfile: getSingerProfile,
    );
  }
}
