import 'package:flutter/material.dart';
import 'package:musicPlayer/database/FavSongeMobileData.dart';
import 'package:musicPlayer/widgets/allText/AppText.dart';

class RecentlyPlayedList extends StatelessWidget {
  final List<FavSongMobileData> favSongMobileDataList;

  const RecentlyPlayedList({Key key, this.favSongMobileDataList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 222,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.all(16.0),
              child: Headline2(text: "Recently Played")),
          Container(
            height: 222,
            // color: Colors.red,
            width: double.infinity,
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: favSongMobileDataList.length,
              itemBuilder: (context, index) {
                FavSongMobileData favSongMobileData =
                    favSongMobileDataList[index];
                return Container(
                  height: 130.33,
                  width: 114.33,
                  child: Padding(
                    padding: EdgeInsets.only(left: 9.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        new Container(
                          height: 114.33,
                          width: 114.33,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(favSongMobileData.artworkUrl),
                            ),
                            borderRadius: BorderRadius.circular(15.00),
                          ),
                        ),
                        LargeBody(text: favSongMobileData.songname)
                      ],
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
