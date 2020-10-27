import 'package:flutter/material.dart';
import 'package:musicPlayer/network_utils/api.dart';
import 'package:musicPlayer/widgets/appNetWorkImage.dart';

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
        print("ININ");
        onClick();
      },
      // leading: Container(
      //   height: 60.00,
      //   width: 60.00,
      //   // decoration: BoxDecoration(
      //   //   image: DecorationImage(
      //   //       image: imageUrl != null
      //   //           ? NetworkImage(imageUrl)
      //   //           : imageUrl != null
      //   //               ? NetworkImage(imageUrl)
      //   //               : NetworkImage(""),
      //   //       fit: BoxFit.cover),
      //   //   borderRadius: BorderRadius.circular(15.00),
      //   // ),
      //   child: AppNetworkImage(
      //     imageUrl: imageUrl != null ? imageUrl : "",
      //   ),
      // ),
      leading: Container(
        height: 60.00,
        width: 60.00,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(imageUrl != null ? imageUrl : ""),
              fit: BoxFit.cover),
          // boxShadow: [
          //   BoxShadow(
          //     offset: Offset(0.00, 3.00),
          //     color: Color(0xff00a650).withOpacity(0.30),
          //     blurRadius: 26,
          //   ),
          // ],
          borderRadius: BorderRadius.circular(15.00),
        ),
      ),
      title: Headline4(text: title),
      subtitle: SMALLCAPTION(text: subtitle),
      trailing: Text(
        duration != null
            ? Network().printDuration(Duration(milliseconds: duration))
            : Network().printDuration(Network().parseDuration(durationString)),
      ),
    );
  }
}
