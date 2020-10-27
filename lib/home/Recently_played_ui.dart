import 'package:flutter/material.dart';
import 'package:musicPlayer/database/FavSongeMobileData.dart';
import 'package:musicPlayer/database/Recently_played.dart';
import 'package:musicPlayer/home/Recently_played.dart';
import 'package:musicPlayer/modal/SingerProfileModal.dart';
import 'package:musicPlayer/modal/SingerTrackModale.dart';
import 'package:musicPlayer/widgets/allText/AppText.dart';

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

  @override
  Widget build(BuildContext context) {
    return RecentlyPlayedList(favSongMobileDataList: favSongMobileDataList);
  }
}
