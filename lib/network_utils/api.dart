import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

class Network {
  // final String _url =
  //     'https://api-v2.soundcloud.com/search?q=love&sc_a_id=7a8d1459-4929-49ae-b105-34c31f52940e&variant_ids=2068&facet=model&user_id=319443-923241-180695-429775&client_id=8rirGfqZBZPpMxmdSA5WjjpowkwD0Ygz&limit=4&offset=0&linked_partitioning=1&app_version=1603104302&app_locale=en';
  var token;
  final String getHomeScreenSongs =
      "https://api-v2.soundcloud.com/mixed-selections?client_id=8rirGfqZBZPpMxmdSA5WjjpowkwD0Ygz&limit=10&offset=0&linked_partitioning=1&app_version=1603104302&app_locale=en";
  String client_id = "?client_id=8rirGfqZBZPpMxmdSA5WjjpowkwD0Ygz";

// String getPlayList=""

  // _getToken() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   token = jsonDecode(localStorage.getString('token'))['token'];
  // }

  getHomeScreenPlayList() async {
    return await http.get(getHomeScreenSongs, headers: _setHeaders());
  }

  getMOreTracks(offset) async {
    return await http.get(
        "${offset}&client_id=8rirGfqZBZPpMxmdSA5WjjpowkwD0Ygz",
        headers: _setHeaders());
    // return await http.get(
    //     "https://api-v2.soundcloud.com/users/70847422/tracks?offset=2020-10-16T08%3A47%3A10.000Z%2Ctracks%2C00911548267&limit=10&client_id=8rirGfqZBZPpMxmdSA5WjjpowkwD0Ygz",
    //     headers: _setHeaders());
  }

  showToastMessage(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  getAllTrackFormSinger(userId) async {
    return await http.get(
        "https://api-v2.soundcloud.com/users/${userId}/tracks?client_id=8rirGfqZBZPpMxmdSA5WjjpowkwD0Ygz",
        headers: _setHeaders());
  }

  getSingerProfile(userID) async {
    return await http.get(
        "https://api-v2.soundcloud.com/users/${userID}?client_id=8rirGfqZBZPpMxmdSA5WjjpowkwD0Ygz",
        headers: _setHeaders());
  }

  getPlayListForId(id) async {
    return await http.get(
        "https://api-v2.soundcloud.com/playlists/${id}?client_id=8rirGfqZBZPpMxmdSA5WjjpowkwD0Ygz",
        headers: _setHeaders());
  }

  getStremUrl(id) async {
    return await http.get(id + client_id, headers: _setHeaders());
  }

  Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        // 'Authorization' : 'Bearer $token'
      };
}
