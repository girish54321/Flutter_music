import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:musicPlayer/helper.dart';
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
      // leading: Container(
      //   height: 60.00,
      //   width: 60.00,
      //   decoration: BoxDecoration(
      //     image: DecorationImage(
      //         image: NetworkImage(imageUrl != null ? imageUrl : ""),
      //         fit: BoxFit.cover),
      //     borderRadius: BorderRadius.circular(15.00),
      //   ), PlaseHolder()
      // ),
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
        imageUrl: imageUrl != null ? imageUrl : "",
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
