import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Network {
  var token;
  final String getHomeScreenSongs =
      "https://api-v2.soundcloud.com/mixed-selections?client_id=8rirGfqZBZPpMxmdSA5WjjpowkwD0Ygz&limit=10&offset=0&linked_partitioning=1&app_version=1603104302&app_locale=en";
  // String client_id = "8rirGfqZBZPpMxmdSA5WjjpowkwD0Ygz";
  String client_id;
 
  CollectionReference clientId =
      FirebaseFirestore.instance.collection('clientId');

  _getToken() async {
    // SharedPreferences localStorage = await SharedPreferences.getInstance();
    // token = jsonDecode(localStorage.getString('token'))['token'];
    await FirebaseFirestore.instance
        .collection('clientId')
        .doc('clientId')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print('Document exists on the database clientId');
        print("OGnew");
        // print("8rirGfqZBZPpMxmdSA5WjjpowkwD0Ygz");
        print(documentSnapshot.get('clientId').toString().trim());

        client_id = documentSnapshot.get('clientId').toString().trim();
        print(client_id);
      } else {}
    });
  }

  getHomeScreenPlayList() async {
    // return await http.get(getHomeScreenSongs, headers: _setHeaders());
    await _getToken();
    return await http.get(
        "https://api-v2.soundcloud.com/mixed-selections?client_id=$client_id&limit=10&offset=0&linked_partitioning=1&app_version=1603104302&app_locale=en",
        headers: _setHeaders());
  }

  getMOreTracks(offset) async {
    await _getToken();
    return await http.get("$offset&client_id=$client_id",
        headers: _setHeaders());
  }

  getAllTrackFormSinger(userId) async {
    await _getToken();
    return await http.get(
        "https://api-v2.soundcloud.com/users/$userId/tracks?client_id=$client_id",
        headers: _setHeaders());
  }

  getSingerProfile(userID) async {
    await _getToken();
    return await http.get(
        "https://api-v2.soundcloud.com/users/$userID?client_id=$client_id",
        headers: _setHeaders());
  }

  getPlayListForId(id) async {
    await _getToken();
    return await http.get(
        "https://api-v2.soundcloud.com/playlists/${id}?client_id=$client_id",
        headers: _setHeaders());
  }

  getStremUrl(id) async {
    await _getToken();
    if (client_id != null) {
      return await http.get(id + '?client_id=$client_id',
          headers: _setHeaders());
    } else {
      return null;
    }
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        // 'Authorization' : 'Bearer $token'
      };
}
