import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicPlayer/animasions/showUp.dart';

// ignore: non_constant_identifier_names
Widget Header(context, toolBarText) {
  return AppBar(
    elevation: 0,
    title: ShowUp(delay: 500, child: Text(toolBarText)),
  );
}
