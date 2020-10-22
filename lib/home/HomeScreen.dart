import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:musicPlayer/modal/homeSongList.dart';
import 'package:musicPlayer/network_utils/api.dart';
import 'package:musicPlayer/screen/playListScreen.dart';
import 'package:musicPlayer/widgets/header.dart';
import 'package:musicPlayer/widgets/verticleBox.dart';
import 'package:http/http.dart' as http;
import 'package:page_transition/page_transition.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  bool get wantKeepAlive => true;

  bool _loading = true;
  HomeSongList homeSongList;

  @override
  void initState() {
    super.initState();
    _loading = true;
    _getSongPlayList();
  }

  _getSongPlayList() async {
    try {
      http.Response response = await Network().getHomeScreenPlayList();
      if (response.statusCode == 200) {
        var resBody = json.decode(response.body);
        homeSongList = new HomeSongList.fromJson(resBody);
        setState(() {
          _loading = false;
        });
      }
    } catch (_) {
      print("response22 ERRERs");
      print(_);
    }
  }

  Widget showList() {
    if (_loading) {
      return Text("Loading");
    } else {
      return Text("Loading Donel̥");
    }
  }

  void goToPlayList(ItemsCollection id, String heroTag) {
    print(heroTag);
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) =>
    //           PlayListScreen(itemsCollection: id, heroTag: heroTag),
    //     ));
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft,
            child: PlayListScreen(itemsCollection: id, heroTag: heroTag)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(context, "Home"),
      body: _loading
          ? Center(
              child: new CircularProgressIndicator(),
            )
          : CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    HomeSongListCollection collection =
                        homeSongList.collection[index];
                    return VerticalBox(
                        collection: collection, goToPlayList: goToPlayList);
                  }, childCount: homeSongList.collection.length),
                ),
              ],
            ),
    );
  }
}
