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
        background: Container(
          decoration: BoxDecoration(
              image: imageUrl != null
                  ? DecorationImage(
                      image: NetworkImage(imageUrl), fit: BoxFit.cover)
                  : PlaseHolder()),
          child: Container(
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(begin: Alignment.bottomCenter, colors: [
              Colors.black,
              Colors.black.withOpacity(.3),
              Colors.transparent,
              Colors.transparent,
              Colors.transparent,
              Colors.transparent,
              Colors.transparent,
              Colors.transparent,
              Colors.transparent,
              Colors.transparent,
              Colors.transparent,
              Colors.transparent,
              Colors.transparent,
              Colors.transparent,
            ])),
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            FadeAnimation(
                              0.4,
                              Row(
                                children: [
                                  Text(
                                    singerProfile.followersCount.toString(),
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
            ),
          ),
        ),
      ),
    );
  }
}
