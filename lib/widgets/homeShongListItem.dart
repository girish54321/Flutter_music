import 'package:flutter/material.dart';
import 'package:musicPlayer/animasions/rightToLeft.dart';
import 'package:musicPlayer/animasions/showUp.dart';
import 'package:musicPlayer/modal/homeSongList.dart';
import 'package:musicPlayer/widgets/allText/AppText.dart';
import 'package:musicPlayer/widgets/appNetWorkImage.dart';

class HomeShongListItem extends StatelessWidget {
  final ItemsCollection itemsCollection;
  final int height;
  final Function goToPlayList;

  const HomeShongListItem(
      {Key key, this.height, this.itemsCollection, this.goToPlayList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding: EdgeInsets.only(right: 14, top: 14.0),
      padding: EdgeInsets.only(left: 16.0, top: 16.0),
      child: RightToLeft(
        delay: 150,
        child: InkWell(
          onTap: () {
            goToPlayList(itemsCollection, itemsCollection.id.toString());
          },
          child: Column(
            children: [
              Container(
                height: 180.00,
                width: 180.00,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  child: itemsCollection.artworkUrl != null
                      ? AppNetworkImage(
                          imageUrl: itemsCollection.artworkUrl
                              .replaceAll("large", "t300x300"),
                        )
                      : itemsCollection.calculatedArtworkUrl != null
                          ? AppNetworkImage(
                              imageUrl: itemsCollection.calculatedArtworkUrl
                                  .replaceAll("large", "t300x300"),
                            )
                          : PlaseHolder(),
                ),
              ),
              Container(
                  width: 180,
                  // alignment: Alignment.topLeft,
                  // color: Colors.red,
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Headline5(
                          text: itemsCollection.title != null
                              ? itemsCollection.title
                              : ""),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                        child: SMALLCAPTION(
                          text: itemsCollection.user.username != null
                              ? itemsCollection.user.username
                              : "",
                        ),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
