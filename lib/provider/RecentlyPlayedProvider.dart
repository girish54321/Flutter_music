import 'package:flutter/material.dart';
import 'package:musicPlayer/database/data_modal/FavSongeMobileData.dart';
import 'package:musicPlayer/database/dataBaseHelper/Recently_played.dart';

class RecentlyPlayedProvider with ChangeNotifier {
  List<FavSongMobileData> favSongMobileDataList = [];

  RecentlyPlayedProvider() {
    updateProviderData();
  }

  void updateList() {
    print("UPDATE LIST");
    favSongMobileDataList.clear();
    updateProviderData();
  }

  void clearList() {
    print("CLINE LIST FAV");
    favSongMobileDataList = [];
    notifyListeners();
  }

  Future<void> updateProviderData() async {
    final dbHelper = RecentlyPlayedDatabaseHelper.instance;
    final allRows = await dbHelper.queryAllRows();
    print('query all rows: PROVIDER');
    if (allRows.length != 0) {
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

        favSongMobileDataList.add(favSongMobileData);
      }
      notifyListeners();
    } else {
      print('query all NO DATA:');
      notifyListeners();
    }
  }
}
