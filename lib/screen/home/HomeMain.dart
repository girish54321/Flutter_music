import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:musicPlayer/helper/helper.dart';
import 'package:musicPlayer/modal/homeSongList.dart';
import 'package:musicPlayer/network_utils/api.dart';
import 'package:musicPlayer/screen/Empty%20Screen/loadingScreen.dart';
import 'package:musicPlayer/screen/home/RecentlyPlayedList/Recently_played_ui.dart';
import 'package:musicPlayer/screen/playListScreen/playListScreen.dart';
import 'package:musicPlayer/widgets/allText/AppText.dart';
import 'package:musicPlayer/widgets/infoView.dart';
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
  String errorMessage;

  @override
  void initState() {
    super.initState();
    _loading = true;
    _getSongPlayList();
  }

  _getSongPlayList() async {
    setState(() {
      _loading = true;
    });
    try {
      http.Response response = await Network().getHomeScreenPlayList();
      if (response.statusCode == 200) {
        var resBody = json.decode(response.body);
        homeSongList = new HomeSongList.fromJson(resBody);
        setState(() {
          _loading = false;
          errorMessage = null;
        });
      } else {
        setState(() {
          _loading = false;
          errorMessage = response.statusCode.toString();
        });
      }
    } catch (e) {
      setState(() {
        _loading = false;
        errorMessage = e.toString();
      });
      print(e);
    }
  }

  goToPlayList(ItemsCollection id, String heroTag) {
    Helper().goToPage(
        context, PlayListScreen(itemsCollection: id, heroTag: heroTag));
  }

  @override
  // ignore: must_call_super
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: SafeArea(
        child: _loading
            ? Center(
                child: new LoadingScreen(),
              )
            : errorMessage != null
                ? ErrorView(
                    errorMessage: errorMessage,
                    function: () {
                      _getSongPlayList();
                    },
                  )
                : CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: <Widget>[
                      SliverToBoxAdapter(
                        child: Recently_playedUI(),
                      ),
                      SliverToBoxAdapter(
                        child: Padding(
                            padding: EdgeInsets.only(left: 16.0, top: 18.0),
                            child: Headline2(text: "Recommended for you")),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                          HomeSongListCollection collection =
                              homeSongList.collection[index];
                          return VerticalBox(
                              collection: collection,
                              goToPlayList: goToPlayList);
                        }, childCount: homeSongList.collection.length),
                      ),
                      SliverToBoxAdapter(
                        child: SizedBox(
                          height: 60,
                        ),
                      ),
                    ],
                  ),
      ),
    );
  }
}
