import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:musicPlayer/animasions/FadeAnimation.dart';
import 'package:musicPlayer/modal/SingerProfileModal.dart';
import 'package:musicPlayer/widgets/appNetWorkImage.dart';

class GardeenAppBar extends StatelessWidget {
  final String imageUrl;
  final String title;
  final bool isProfile;
  final SingerProfile singerProfile;

  const GardeenAppBar(
      {Key key, this.imageUrl, this.title, this.isProfile, this.singerProfile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 364,
      pinned: true,
      // backgroundColor: Colors.black,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        background: CachedNetworkImage(
          placeholder: (context, url) => PlaseHolder(),
          imageUrl: imageUrl != null
              ? imageUrl
              : "https://api.time.com/wp-content/uploads/2018/04/listening-to-music-headphones.jpg?quality=85&w=1024&h=512&crop=1",
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            )),
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                    Colors.black,
                    Colors.black.withOpacity(.3),
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                    Colors.transparent,
                  ])),
              child: Padding(
                // padding: EdgeInsets.all(16),
                padding: EdgeInsets.only(bottom: 8, left: 16, right: 16),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        isProfile
                            ? Text(
                                "ARTIST",
                                style: TextStyle(
                                  fontFamily: "Poppins",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              )
                            : Text(""),
                        FadeAnimation(
                            0.4,
                            Text(
                              title,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40),
                            )),
                        SizedBox(
                          height: 6,
                        ),
                        isProfile
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  FadeAnimation(
                                    0.4,
                                    Row(
                                      children: [
                                        Text(
                                          singerProfile.followersCount
                                              .toString(),
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 16),
                                        ),
                                        Text(
                                          " Followers",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ),
                                  FadeAnimation(
                                    0.4,
                                    Row(
                                      children: [
                                        Text(
                                          singerProfile.trackCount.toString(),
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 16),
                                        ),
                                        Text(
                                          " Tracks",
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ),
                                  FadeAnimation(
                                      0.4,
                                      Row(children: <Widget>[
                                        Icon(
                                          Icons.thumb_up,
                                          color: Theme.of(context).accentColor,
                                        ),
                                        SizedBox(
                                          width: 8.0,
                                        ),
                                        Text(
                                          singerProfile.likesCount.toString(),
                                          style: TextStyle(
                                              color: Colors.grey, fontSize: 16),
                                        ),
                                      ]))
                                ],
                              )
                            : SizedBox(
                                width: 1,
                              ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            height: 150.0,
            child: Icon(Icons.error),
          ),
        ),
      ),
    );
  }
}
