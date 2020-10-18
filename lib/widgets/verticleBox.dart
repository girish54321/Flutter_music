import 'package:flutter/material.dart';

import 'appImageView.dart';

class VerticalBox extends StatelessWidget {
  final String image;

  // receive data from the FirstScreen as a parameter
  VerticalBox({Key key, @required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      padding: EdgeInsets.all(12.0),
      height: 230,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "For You",
            style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),
          ),
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, index) {
                return AppImageView(
                  image: "https://i.pinimg.com/originals/3d/fc/ed/3dfced4a6e2994f536477b071d283a23.jpg",
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
