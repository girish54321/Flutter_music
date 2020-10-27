import 'package:flutter/material.dart';
import 'package:musicPlayer/animasions/rightToLeft.dart';
import 'package:musicPlayer/database/FavSongeMobileData.dart';
import 'package:musicPlayer/widgets/allText/AppText.dart';
import 'package:musicPlayer/widgets/appNetWorkImage.dart';

class RecentlyPlayedList extends StatelessWidget {
  final List<FavSongMobileData> favSongMobileDataList;
  final Function sendSongUrlToPlayer;
  const RecentlyPlayedList(
      {Key key, this.favSongMobileDataList, this.sendSongUrlToPlayer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(left: 16.0, top: 18.0, bottom: 8.0),
              child: Headline2(text: "Recently Played")),
          Container(
            height: 230,
            // color: Colors.red,
            width: double.infinity,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: favSongMobileDataList.length,
              itemBuilder: (context, index) {
                FavSongMobileData favSongMobileData =
                    favSongMobileDataList[index];
                return RightToLeft(
                  delay: 150,
                  child: Container(
                    height: 230,
                    child: InkWell(
                      onTap: () {
                        sendSongUrlToPlayer(favSongMobileData);
                      },
                      child: Container(
                        // height: 130.33,
                        width: 140.33,
                        child: Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              new Container(
                                height: 130.33,
                                width: 130.33,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: favSongMobileData.artworkUrl != null
                                      ? AppNetworkImage(
                                          imageUrl:
                                              favSongMobileData.artworkUrl)
                                      : PlaseHolder(),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.only(top: 4.0),
                                  child: CaptionL(
                                      text: favSongMobileData.songname))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
