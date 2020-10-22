import 'package:flutter/material.dart';
import 'package:musicPlayer/animasions/rightToLeft.dart';
import 'package:musicPlayer/animasions/showUp.dart';
import 'package:musicPlayer/modal/homeSongList.dart';
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
    return RightToLeft(
      delay: 150,
      child: InkWell(
        onTap: () {
          goToPlayList(itemsCollection, itemsCollection.id.toString());
        },
        child: Padding(
          padding: EdgeInsets.only(top: 6.0, bottom: 2.0, right: 14.0),
          child: Column(
            children: [
              Stack(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(2.0),
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
                  Positioned(
                    bottom: 0,
                    top: 0,
                    right: 0,
                    left: 0,
                    child: Center(
                      child: IconButton(
                          icon: Icon(
                            Icons.play_circle_outline,
                            size: 33,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            goToPlayList(
                                itemsCollection, itemsCollection.id.toString());
                          }),
                    ),
                  ),
                ],
              ),
              Container(
                  width: height != null ? height : 140,
                  alignment: Alignment.topLeft,
                  // color: Colors.red,
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        itemsCollection.title != null
                            ? itemsCollection.title
                            : "",
                        maxLines: 2,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                        child: Text(
                          itemsCollection.user.username != null
                              ? itemsCollection.user.username
                              : "",
                          style: TextStyle(color: Colors.grey, fontSize: 10),
                          maxLines: 2,
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
