import 'package:flutter/material.dart';
import 'package:musicPlayer/widgets/header.dart';
import 'package:musicPlayer/widgets/verticleBox.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  bool get wantKeepAlive => true;

  List _buildList(int count) {
    List<Widget> listItems = List();

    for (int i = 0; i < count; i++) {
      listItems.add(new Padding(
          padding: new EdgeInsets.all(20.0),
          child: new Text('Item ${i.toString()}',
              style: new TextStyle(fontSize: 25.0))));
    }

    return listItems;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(context, "Home"),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: VerticalBox(
              image: "https://picsum.photos/200",
            ),
          ),
           SliverToBoxAdapter(
            child: VerticalBox(
              image: "https://picsum.photos/200",
            ),
          ),
           SliverToBoxAdapter(
            child: VerticalBox(
              image: "https://picsum.photos/200",
            ),
          ),
           SliverToBoxAdapter(
            child: VerticalBox(
              image: "https://picsum.photos/200",
            ),
          ),
          SliverList(delegate: new SliverChildListDelegate(_buildList(50))),
        ],
      ),
    );
  }
}
