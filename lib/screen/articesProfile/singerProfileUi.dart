import 'package:flutter/material.dart';
import 'package:musicPlayer/modal/SingerProfileModal.dart';
import 'package:musicPlayer/modal/SingerTrackModale.dart';
import 'package:musicPlayer/provider/RecentlyPlayedProvider.dart';
import 'package:musicPlayer/screen/LoadingScreen/loadingScreen.dart';
import 'package:musicPlayer/widgets/gradientAppBar.dart';
import 'package:musicPlayer/widgets/songListItem.dart';
import 'package:provider/provider.dart';

class SingerProfileUi extends StatelessWidget {
  final bool loading;
  final ScrollController scrollController;
  final String avatarUrl;
  final SingerProfile singerProfile;
  final SingerTracksModal singerTracksModal;
  final bool loadingMore;
  final Function sendSongUrlToPlayer;

  const SingerProfileUi(
      {Key key,
      this.loading,
      this.scrollController,
      this.avatarUrl,
      this.singerProfile,
      this.singerTracksModal,
      this.loadingMore,
      this.sendSongUrlToPlayer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Center(
              child: Center(
                child: new LoadingScreen(),
              ),
            )
          : CustomScrollView(
              controller: scrollController,
              slivers: <Widget>[
                GardeenAppBar(
                    // imageUrl: widget.track.user.avatarUrl
                    //     .replaceAll("large", "t500x500"),
                    imageUrl: avatarUrl.replaceAll("large", "t500x500"),
                    title: singerProfile.username,
                    singerProfile: singerProfile,
                    isProfile: true),
                SliverList(
                  delegate: SliverChildListDelegate([
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 18, vertical: 18),
                          child: Text(
                            singerProfile.description,
                            style: TextStyle(height: 1.4),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: Text(
                            "Created At",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 18),
                          child: Text(
                            singerProfile.createdAt.toUtc().toString(),
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 18, vertical: 18),
                          child: Text(
                            "All Tracks",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        if (singerTracksModal != null)
                          ...singerTracksModal.collection
                              .asMap()
                              .entries
                              .map((MapEntry map) {
                            Collection collection =
                                singerTracksModal.collection[map.key];
                            return Consumer<RecentlyPlayedProvider>(builder:
                                (context, recentlyPlayedProvider, child) {
                              return Container(
                                margin: EdgeInsets.only(top: 4.0),
                                child: Column(
                                  children: [
                                    SongListItem(
                                        onClick: () {
                                          sendSongUrlToPlayer(
                                              collection,
                                              recentlyPlayedProvider
                                                  .updateList);
                                        },
                                        imageUrl: collection.artworkUrl,
                                        title: collection.title != null
                                            ? collection.title
                                            : "Title Not Avalive",
                                        subtitle: collection.user != null
                                            ? collection.user.username != null
                                                ? collection.user.username
                                                : ""
                                            : "Artise Name Not Found",
                                        duration: collection
                                            .media.transcodings[1].duration),
                                    Divider()
                                  ],
                                ),
                              );
                            });
                          }).toList(),
                        Center(
                          child: loadingMore
                              ? Container(
                                  margin: EdgeInsets.symmetric(vertical: 18),
                                  child: CircularProgressIndicator())
                              : Text(""),
                        ),
                      ],
                    ),
                  ]),
                )
              ],
            ),
    );
  }
}
