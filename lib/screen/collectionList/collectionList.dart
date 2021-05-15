import 'package:flutter/material.dart';
import 'package:musicPlayer/helper/helper.dart';
import 'package:musicPlayer/modal/homeSongList.dart';
import 'package:musicPlayer/screen/playListScreen/playListScreen.dart';
import 'package:musicPlayer/widgets/homeShongListItem.dart';

class CollectionList extends StatefulWidget {
  final List<ItemsCollection> collection;
  final String title;
  CollectionList({Key key, @required this.collection, @required this.title})
      : super(key: key);

  @override
  _CollectionListState createState() => _CollectionListState();
}

class _CollectionListState extends State<CollectionList> {
  goToPlayList(ItemsCollection id, String heroTag) {
    Helper().goToPage(
        context, PlayListScreen(itemsCollection: id, heroTag: heroTag));
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // ignore: unused_local_variable
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: GridView.builder(
        itemCount: widget.collection.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
          childAspectRatio: (itemWidth / 261),
        ),
        itemBuilder: (
          context,
          index,
        ) {
          ItemsCollection itemsCollection = widget.collection[index];
          return HomeShongListItem(
              leftPadding: 0.0,
              itemsCollection: itemsCollection,
              goToPlayList: goToPlayList);
        },
      ),
    );
  }
}
