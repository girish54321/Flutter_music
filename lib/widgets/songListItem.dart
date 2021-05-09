import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:musicPlayer/helper/helper.dart';
import 'allText/AppText.dart';

class SongListItem extends StatelessWidget {
  final Function onClick;
  final String imageUrl;
  final String title;
  final String subtitle;
  final int duration;
  final String durationString;

  const SongListItem(
      {Key key,
      this.onClick,
      this.imageUrl,
      this.title,
      this.subtitle,
      this.duration,
      this.durationString})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        onClick();
      },
      leading: CachedNetworkImage(
        placeholder: (context, url) => Container(
          height: 60.00,
          width: 60.00,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/placholder.jpg'),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(15.00),
          ),
        ),
        imageUrl: imageUrl != null
            ? imageUrl
            : "https://api.time.com/wp-content/uploads/2018/04/listening-to-music-headphones.jpg?quality=85&w=1024&h=512&crop=1",
        imageBuilder: (context, imageProvider) => Container(
          height: 60.00,
          width: 60.00,
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(15.00),
          ),
        ),
        errorWidget: (context, url, error) => Container(
          height: 150.0,
          child: Icon(Icons.error),
        ),
      ),
      title: Headline4(text: title),
      subtitle: SMALLCAPTION(text: subtitle),
      trailing: Text(
        duration != null
            ? Helper().printDuration(Duration(milliseconds: duration))
            : Helper().printDuration(Helper().parseDuration(durationString)),
      ),
    );
  }
}
