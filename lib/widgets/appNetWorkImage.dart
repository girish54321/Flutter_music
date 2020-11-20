import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final int height;
  const AppNetworkImage({Key key, this.imageUrl, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fadeInDuration: Duration(milliseconds: 400),
      fadeOutDuration: Duration(milliseconds: 200),
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          borderRadius: BorderRadius.circular(15.00),
        ),
      ),
      placeholder: (context, url) => PlaseHolder(),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}

class PlaseHolder extends StatelessWidget {
  final int height;

  const PlaseHolder({Key key, this.height}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Image(
      image: AssetImage('assets/images/placholder.jpg'),
      height: height != null ? height : 150,
      fit: BoxFit.fill,
    );
  }
}
