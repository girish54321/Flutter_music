import 'package:flutter/material.dart';
import 'package:musicPlayer/network_utils/api.dart';

import 'allText/AppText.dart';

class SongListItem extends StatelessWidget {
  final Function onClick;
  final String imageUrl;
  final String title;
  final String subtitle;
  final int duration;

  const SongListItem(
      {Key key,
      this.onClick,
      this.imageUrl,
      this.title,
      this.subtitle,
      this.duration})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: () {
          print("ININ");
          onClick();
        },
        leading: Container(
          height: 60.00,
          width: 60.00,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: imageUrl != null
                    ? NetworkImage(imageUrl)
                    : imageUrl != null
                        ? NetworkImage(imageUrl)
                        : NetworkImage(""),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(15.00),
          ),
        ),
        title: Headline4(text: title),
        subtitle: SMALLCAPTION(text: subtitle),
        trailing:
            Text(Network().printDuration(Duration(milliseconds: duration))));
  }
}
