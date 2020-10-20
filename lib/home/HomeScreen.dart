import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:musicPlayer/modal/homeSongList.dart';
import 'package:musicPlayer/network_utils/api.dart';
import 'package:musicPlayer/widgets/header.dart';
import 'package:musicPlayer/widgets/verticleBox.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  bool get wantKeepAlive => true;
  // SongPlayList songPlayList;
  // List<Collection> collectionList = [];
  bool _loading = true;
  HomeSongList homeSongList;
  var headers = {
    // 'Authorization': 'Bearer ' + Const.KEY,
    'Content-type': 'application/json',
    'Accept': 'application/json',
  };

  // List _buildList(SongPlayList songs) {
  //   List<Widget> listItems = List();
  //   print("IN VV");
  //   print(songs.collection);
  //   for (int i = 0; i < songs.collection.length; i++) {
  //     listItems.add(new Padding(
  //         padding: new EdgeInsets.all(20.0),
  //         child: new Text('Item ${i.toString()}',
  //             style: new TextStyle(fontSize: 25.0))));
  //   }
  //   return listItems;
  // }

  @override
  void initState() {
    super.initState();
    _loading = true;
    _getSongPlayList();
  }

  _getSongPlayList() async {
    print("NEW CODE 1111");
    try {
      http.Response response = await Network().getHomeScreenPlayList();
      print("HOME SCREEN${response.body}");
      var resBody = json.decode(response.body);

      homeSongList = new HomeSongList.fromJson(resBody);
      print(homeSongList.collection[0]);

      List<HomeSongListCollection> collection = homeSongList.collection;
      // for (int ctr = 1; ctr <= collection.length; ctr++) {
      //   print(collection[ctr].description);
      // }

      // http.Response response = await http.get(
      //     // 'https://api.jsonbin.io/b/5f8d96da058d9a7b94dda2f0',
      //     "https://api-v2.soundcloud.com/search?q=love&sc_a_id=7a8d1459-4929-49ae-b105-34c31f52940e&variant_ids=2068&facet=model&user_id=319443-923241-180695-429775&client_id=8rirGfqZBZPpMxmdSA5WjjpowkwD0Ygz&limit=20&offset=0&linked_partitioning=1&app_version=1603104302&app_locale=en",
      //     headers: headers);
      // print("response");
      // var resBody = json.decode(response.body);
      // print(resBody);
      // for (int ctr = 1; ctr <= 5; ctr++) {
      //   print(ctr);
      // }
      // print(resBody['collection'].length);
      // for (int i = 0; resBody['collection'].length; i++) {
      //   print(resBody['collection'][i]);
      // }collection
      // for (int ctr = 1; ctr <= 2; ctr++) {
      //   Collection collection =
      //       new Collection.fromJson(resBody['collection'][ctr]);
      //   print(collection.firstName);

      //   collectionList.add(collection);

      //   print(ctr);
      // }
      setState(() {
        _loading = false;
      });
      //  songPlayList = new SongPlayList.fromJson(resBody);
      // collectionList.a
      // setState(() {
      //   _loading = false;
      // songPlayList = new SongPlayList.fromJson(resBody);
      // });
      print("response2233");
      // print(songPlayList.collection.length);
      // collectionList = songPlayList.collection;
      // print(collectionList[0].description);
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
                      collection: collection,
                    );
                  }, childCount: homeSongList.collection.length),
                ),
              ],
            ),
    );
  }
}
