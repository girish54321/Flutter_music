import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'articesProfile/singerProfile.dart';
import 'home/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter ',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: AudioServiceWidget(child: MyHomePage()));
        // home: SingerProgile());
    // home: BGAudioPlayerScreen());
    // home: OpenContainerTransformDemo());
  }
}
