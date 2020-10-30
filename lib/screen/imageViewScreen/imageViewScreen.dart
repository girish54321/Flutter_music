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
