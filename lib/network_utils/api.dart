import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

class Network {
  // final String _url =
  //     'https://api-v2.soundcloud.com/search?q=love&sc_a_id=7a8d1459-4929-49ae-b105-34c31f52940e&variant_ids=2068&facet=model&user_id=319443-923241-180695-429775&client_id=8rirGfqZBZPpMxmdSA5WjjpowkwD0Ygz&limit=4&offset=0&linked_partitioning=1&app_version=1603104302&app_locale=en';
  var token;
  final String fullUrl =
      "https://api-v2.soundcloud.com/mixed-selections?client_id=8rirGfqZBZPpMxmdSA5WjjpowkwD0Ygz&limit=10&offset=0&linked_partitioning=1&app_version=1603104302&app_locale=en";
  String client_id = "?client_id=8rirGfqZBZPpMxmdSA5WjjpowkwD0Ygz";

  // _getToken() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   token = jsonDecode(localStorage.getString('token'))['token'];
  // }

  getHomeScreenPlayList() async {
    return await http.get(fullUrl,headers: _setHeaders());
  }

  // authData(data, apiUrl) async {
  //   var fullUrl = _url + apiUrl;
  //   return await http.post(fullUrl,
  //       body: jsonEncode(data), headers: _setHeaders());
  // }

  // getData(apiUrl) async {
  //   var fullUrl = _url + apiUrl;
  //   // await _getToken();
  //   return await http.get(fullUrl, headers: _setHeaders());
  // }

  // getSoungPlayList() async {
  //   // var fullUrl = _url + apiUrl;
  //   // await _getToken();
  //   return await http.get(_url, headers: _setHeaders());
  // }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        // 'Authorization' : 'Bearer $token'
      };
}
