import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:musicPlayer/screen/imageViewScreen/imageViewScreen.dart';
import 'package:musicPlayer/widgets/allText/AppText.dart';
import 'package:page_transition/page_transition.dart';

class CoverArt extends StatelessWidget {
  final MediaItem mediaItem;

  const CoverArt({Key key, @required this.mediaItem}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: ImageViewScreen(
                        imageUrl: mediaItem.artUri, heroTag: "heroTag")));
          },
          child: Hero(
            tag: "heroTag",
            child: CachedNetworkImage(
              imageUrl: mediaItem.artUri,
              imageBuilder: (context, imageProvider) => Container(
                height: size.width * 0.7,
                width: size.width * 0.7,
                // height: 300,
                // width: 300,
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 5.0,
                    ),
                  ],
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20.00),
                ),
              ),
              placeholder: (context, url) => Container(
                height: size.width * 0.7,
                width: size.width * 0.7,
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 40.0,
                    ),
                  ],
                  image: DecorationImage(
                      image: AssetImage('assets/images/placholder.jpg'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20.00),
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
        SingerName(
          name: mediaItem.artist,
          title: mediaItem.title,
        ),
      ],
    );
  }
}

class SingerName extends StatelessWidget {
  final String title;
  final String name;

  const SingerName({Key key, this.title, this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 18,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 26),
          child: Center(
            child: Text(
              title != null ? title : "",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
        ),
        Center(
            child: FlatButton(
          child: LargeBody(
            text: name != null ? name : "",
          ),
          onPressed: () {},
        )),
      ],
    );
  }
}
