import 'package:flutter/material.dart';

class AppImageView extends StatelessWidget {
  final String image;
  final int height;
  const AppImageView({Key key, @required this.image, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 14.0, bottom: 12.0, right: 14.0),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              image,
              height: height != null ? height : 150,
            ),
          ),
          Container(
            alignment: Alignment.center,
            height: 150,
            width: 150,
            child: Center(
              child: IconButton(
                  icon: Icon(
                    Icons.play_circle_outline,
                    size: 33,
                    color: Colors.white,
                  ),
                  onPressed: () {}),
            ),
          ),
          Positioned(
            bottom: 1,
            child: Container(
              padding: EdgeInsets.all(9.0),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Title",
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      "Title",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    )
                  ],
                ),
              ),
              margin: EdgeInsets.only(bottom: 7.0),
              height: 50,
              width: 150,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0)),
                gradient: new LinearGradient(
                    colors: [
                      const Color(0xFF000000),
                      const Color(0xFF00000000),
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
