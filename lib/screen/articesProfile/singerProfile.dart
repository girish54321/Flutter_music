import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musicPlayer/MisicPlayer/MusicPlayerScreen.dart';
import 'package:musicPlayer/modal/SingerProfileModal.dart';
import 'package:musicPlayer/modal/SingerTrackModale.dart';
import 'package:musicPlayer/modal/audio_url.dart';
import 'package:musicPlayer/modal/player_song_list.dart';
import 'package:musicPlayer/network_utils/api.dart';
import 'package:http/http.dart' as http;
import 'package:musicPlayer/screen/articesProfile/singerProfileUi.dart';
import 'package:page_transition/page_transition.dart';
import 'package:progress_dialog/progress_dialog.dart';

import 'package:flutter/material.dart';
import 'package:musicPlayer/modal/playListResponse.dart' as playList;

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
  int _currentMax = 10;
  bool _loadingMore = true;
  List<NowPlayingClass> nowPlaying = [];
  AudioUrl audioUrl;

  @override
  void initState() {
    super.initState();
    print("sfd");
    print(widget.nowPlayingClass.singerId);
    Future.delayed(Duration.zero, () {
      if (widget.nowPlayingClass != null) {
        getSingerProfile(widget.nowPlayingClass.singerId);
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
      http.Response response =
          await Network().getMOreTracks(newPageRef); //147072974

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
      _loadingMore = false;
      print(e);
    }
  }

  Future<void> getSingerProfile(userId) async {
    try {
      http.Response response = await Network().getSingerProfile(userId);

      if (response.statusCode == 200) {
        var resBody = json.decode(response.body);
        setState(() {
          _loading = false;
          singerProfile = new SingerProfile.fromJson(resBody);
        });

        getSignerSonges(userId);
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
      // pr.hide();
      print(e);
    }
  }

  Future<void> getSignerSonges(userId) async {
    try {
      http.Response response =
          await Network().getAllTrackFormSinger(userId); //147072974

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
      // pr.hide();
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

  static const int _COUNT = 10;
  // mocking a network call
  Future<List<String>> pageData(int previousCount) async {
    await Future.delayed(Duration(seconds: 0, milliseconds: 1800));
    List<String> dummyList = List();
    if (previousCount < 30) {
      // stop loading after 30 items
      for (int i = previousCount; i < previousCount + _COUNT; i++) {
        dummyList.add('Item $i');
      }
    }
    return dummyList;
  }

  Future<void> sendSongUrlToPlayer(Collection collection) async {
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
        pr.hide();
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
    return SingerProfileUi(
      avatarUrl:
          widget.nowPlayingClass.imageUrl.replaceAll("large", "t500x500"),
      loading: _loading,
      loadingMore: _loadingMore,
      scrollController: _scrollController,
      singerProfile: singerProfile,
      singerTracksModal: singerTracksModal,
      sendSongUrlToPlayer: sendSongUrlToPlayer,
    );
  }
}
