import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class Network {
  var token;
  final String getHomeScreenSongs =
      "https://api-v2.soundcloud.com/mixed-selections?client_id=8rirGfqZBZPpMxmdSA5WjjpowkwD0Ygz&limit=10&offset=0&linked_partitioning=1&app_version=1603104302&app_locale=en";

  String clientID;

  CollectionReference clientId =
      FirebaseFirestore.instance.collection('clientId');

  _getToken() async {
    await FirebaseFirestore.instance
        .collection('clientId')
        .doc('clientId')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        clientID = documentSnapshot.get('clientId').toString().trim();
      } else {}
    });
  }

  getHomeScreenPlayList() async {
    await _getToken();
    return await http.get(
        "https://api-v2.soundcloud.com/mixed-selections?client_id=$clientID&limit=10&offset=0&linked_partitioning=1&app_version=1603104302&app_locale=en",
        headers: _setHeaders());
  }

  getMOreTracks(offset) async {
    await _getToken();
    return await http.get("$offset&client_id=$clientID",
        headers: _setHeaders());
  }

  getAllTrackFormSinger(userId) async {
    await _getToken();
    return await http.get(
        "https://api-v2.soundcloud.com/users/$userId/tracks?client_id=$clientID",
        headers: _setHeaders());
  }

  getSingerProfile(userID) async {
    await _getToken();
    return await http.get(
        "https://api-v2.soundcloud.com/users/$userID?client_id=$clientID",
        headers: _setHeaders());
  }

  getPlayListForId(id) async {
    await _getToken();
    return await http.get(
        "https://api-v2.soundcloud.com/playlists/$id?client_id=$clientID",
        headers: _setHeaders());
  }

  getStremUrl(id) async {
    await _getToken();
    if (clientID != null) {
      return await http.get(id + '?client_id=$clientID',
          headers: _setHeaders());
    } else {
      return null;
    }
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };
}
