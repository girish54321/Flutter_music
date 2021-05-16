import 'package:flutter/material.dart';
import 'package:musicPlayer/helper/helper.dart';
import 'package:musicPlayer/modal/homeSongList.dart';
import 'package:musicPlayer/screen/collectionList/collectionList.dart';
import 'package:musicPlayer/widgets/allText/AppText.dart';

import 'homeShongListItem.dart';

class VerticalBox extends StatelessWidget {
  final HomeSongListCollection collection;
  final Function goToPlayList;
  VerticalBox({Key key, this.collection, this.goToPlayList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Headline4(text: collection.title)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: SMALLCAPTION(text: collection.description),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0),
              child: TextButton(
                onPressed: () {
                  Helper().goToPage(
                      context,
                      CollectionList(
                          collection: collection.items.collection,
                          title: collection.title),
                      false);
                },
                child: Text("View All"),
              ),
            )
          ]),
          Container(
            height: 265,
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
          Divider(),
        ],
      ),
    );
  }
}
