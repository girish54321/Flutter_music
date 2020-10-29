import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewScreen extends StatelessWidget {
  final String imageUrl;
  final String heroTag;

  const ImageViewScreen({Key key, this.imageUrl, this.heroTag})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //https://www.gameinformer.com/s3/files/styles/body_default/s3/legacy-images/imagefeed/Tomb%20Raider%27s%20Writer%20Discusses%20The%20Evolution%20Of%20Lara%20Croft/4162.lara.jpg
        body: Container(
      height: double.infinity,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Hero(
          tag: heroTag,
          child: Container(
            height: double.infinity,
            width: double.infinity,
            child: PhotoView(
              imageProvider: imageProvider,
            ),
          ),
        ),
        placeholder: (context, url) => PhotoView(
          imageProvider: AssetImage('assets/images/placholder.jpg'),
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    ));
  }
}
