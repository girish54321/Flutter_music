import 'dart:convert';

import 'package:flushbar/flushbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musicPlayer/MisicPlayer/MusicPlayerScreen.dart';
import 'package:musicPlayer/modal/SingerProfileModal.dart';
import 'package:musicPlayer/modal/SingerTrackModale.dart';
import 'package:musicPlayer/modal/audio_url.dart';
import 'package:musicPlayer/modal/player_song_list.dart';
import 'package:musicPlayer/network_utils/api.dart';
import 'package:musicPlayer/widgets/allText/AppText.dart';
import 'package:musicPlayer/widgets/gradientAppBar.dart';
import 'package:musicPlayer/widgets/header.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../animasions/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:musicPlayer/modal/playListResponse.dart' as playList;

class SingerProgile extends StatefulWidget {
  final playList.Track track;

  const SingerProgile({Key key, this.track}) : super(key: key);
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
    if (widget.track != null) {
      print(widget.track.user.id);
      getSingerProfile(widget.track.user.id);
      // getSingerProfile(147072974);
    } else {
      Fluttertoast.showToast(
          msg: "Error Loading Singer",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.orange,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    // getSingerProfile(147072974);
    // myList = List.generate(10, (i) => "Item : ${i + 1}");
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
    print("GIOVE me data");
    print("GET SONGS");
    print(newPageRef);
    try {
      http.Response response =
          await Network().getMOreTracks(newPageRef); //147072974

      print(response.statusCode);
      if (response.statusCode == 200) {
        var resBody = json.decode(response.body);
        setState(() {
          _loading = false;
        });
        print("New songe");
        print("nextHref");
        print(resBody['next_href']);
        setState(() {
          newPageRef = resBody['next_href'];
        });
        // Collection Collection = new Collection.fromJson(resBody);
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
        // singerProfile = new SingerProfile.fromJson(resBody);
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
      _loadingMore = false;
      print(e);
    }
  }

  Future<void> getSingerProfile(userId) async {
    print("GET PROFILE");
    try {
      http.Response response = await Network().getSingerProfile(userId);
      // print(response.body);
      if (response.statusCode == 200) {
        var resBody = json.decode(response.body);
        setState(() {
          _loading = false;
        });
        singerProfile = new SingerProfile.fromJson(resBody);
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
    print("GET SONGS");
    try {
      http.Response response =
          await Network().getAllTrackFormSinger(userId); //147072974
      // print(response.body);
      if (response.statusCode == 200) {
        var resBody = json.decode(response.body);
        setState(() {
          _loading = false;
        });
        print("collection");
        print(resBody['collection'].length);
        setState(() {
          singerTracksModal = new SingerTracksModal.fromJson(resBody);
        });

        // for (int i = 0; i <= resBody['collection'].length; i++) {
        //   SingerTracksModal singerTracksModal =
        //       new SingerTracksModal.fromJson(resBody['collection'][i]);
        //   setState(() {
        //     collection.add(singerTracksModal);
        //   });
        // }
        setState(() {
          newPageRef = singerTracksModal.nextHref;
        });
        print(resBody['collection'].length);
        // singerProfile = new SingerProfile.fromJson(resBody);
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
        nowPlaying.add(new NowPlayingClass(
            audioUrl.url,
            collection.title,
            singerName,
            collection.artworkUrl,
            null,
            Duration(milliseconds: collection.media.transcodings[1].duration)));
        pr.hide();
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: BGAudioPlayerScreen(
                    nowPlayingClass: nowPlaying, track: null)));
        await Future.delayed(Duration(seconds: 5));
        nowPlaying.clear();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      body: _loading || singerTracksModal.collection.length == 0
          ? Center(
              child: Center(
                child: new CircularProgressIndicator(),
              ),
            )
          : CustomScrollView(
              controller: _scrollController,
              slivers: <Widget>[
                GardeenAppBar(
                    imageUrl: widget.track.user.avatarUrl
                        .replaceAll("large", "t500x500"),
                    // imageUrl: "",
                    title: singerProfile.username,
                    singerProfile: singerProfile,
                    isProfile: true),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 18, vertical: 18),
                          child: FadeAnimation(
                              1.6,
                              Text(
                                singerProfile.description,
                                style: TextStyle(height: 1.4),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: FadeAnimation(
                              1.6,
                              Text(
                                "Created At",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: FadeAnimation(
                              1.6,
                              Text(
                                singerProfile.createdAt.toUtc().toString(),
                                style: TextStyle(color: Colors.grey),
                              )),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 18, vertical: 18),
                          child: FadeAnimation(
                              1.6,
                              Text(
                                "All Tracks",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )),
                        ),
                        ...singerTracksModal.collection
                            .asMap()
                            .entries
                            .map((MapEntry map) {
                          Collection collection =
                              singerTracksModal.collection[map.key];
                          return Container(
                            margin: EdgeInsets.only(top: 4.0),
                            child: Column(
                              children: [
                                ListTile(
                                  onTap: () {
                                    sendSongUrlToPlayer(collection);
                                  },
                                  // title: Text(collection.title),
                                  title: Headline4(text: collection.title),
                                  trailing: collection.media != null
                                      ? Text(Network().printDuration(Duration(
                                          milliseconds: collection
                                              .media.transcodings[1].duration)))
                                      : Text(""),
                                  // leading: CircleAvatar(
                                  //   radius: 24.0,
                                  //   backgroundImage: collection.artworkUrl !=
                                  //           null
                                  //       ? NetworkImage(collection.artworkUrl)
                                  //       : NetworkImage(collection.artworkUrl),
                                  //   backgroundColor: Colors.transparent,
                                  // ),
                                  leading: Container(
                                    height: 60.00,
                                    width: 60.00,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: collection.artworkUrl != null
                                              ? NetworkImage(
                                                  collection.artworkUrl)
                                              : NetworkImage(
                                                  collection.artworkUrl),
                                          fit: BoxFit.cover),
                                      borderRadius:
                                          BorderRadius.circular(15.00),
                                    ),
                                  ),
                                  subtitle: SMALLCAPTION(
                                      text: collection.createdAt
                                          .toLocal()
                                          .toString()),
                                  // subtitle: Text(
                                  //   collection.createdAt.toLocal().toString(),
                                  //   maxLines: 2,
                                  // ),
                                ),
                                Divider()
                              ],
                            ),
                          );
                        }).toList(),
                        Center(
                          child: _loadingMore
                              ? Container(
                                  margin: EdgeInsets.symmetric(vertical: 18),
                                  child: CircularProgressIndicator())
                              : Text(""),
                        ),
                      ],
                    ),
                  ]),
                )
              ],
            ),
    );
  }

  Widget makeVideo({image}) {
    return AspectRatio(
      aspectRatio: 1.5 / 1,
      child: Container(
        margin: EdgeInsets.only(right: 18),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            image:
                DecorationImage(image: NetworkImage(image), fit: BoxFit.cover)),
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.bottomRight, colors: [
            Colors.black.withOpacity(.9),
            Colors.black.withOpacity(.3)
          ])),
          child: Align(
            child: Icon(
              Icons.play_arrow,
              size: 70,
            ),
          ),
        ),
      ),
    );
  }
}
