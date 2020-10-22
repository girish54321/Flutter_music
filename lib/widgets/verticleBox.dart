import 'package:flutter/material.dart';
import 'package:musicPlayer/modal/homeSongList.dart';

import 'homeShongListItem.dart';

class VerticalBox extends StatelessWidget {
  final HomeSongListCollection collection;
  final Function goToPlayList;
  VerticalBox({Key key, this.collection, this.goToPlayList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      padding: EdgeInsets.all(12.0),
      height: 300,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            collection.title,
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 6.0),
            child: Text(
              collection.description,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Container(
            height: 220,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: collection.items.collection.length,
              itemBuilder: (context, index) {
                ItemsCollection itemsCollection =
                    collection.items.collection[index];
                return HomeShongListItem(
                    itemsCollection: itemsCollection,
                    goToPlayList: goToPlayList);
              },
            ),
          ),
        ],
      ),
    );
  }
}
