import 'package:flutter/material.dart';
import 'package:musicPlayer/widgets/header.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin<SearchScreen> {
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(context, "Search"),
      body: Center(
        child: Text("Search"),
      ),
    );
  }
}
