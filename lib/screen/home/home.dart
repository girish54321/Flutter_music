import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicPlayer/screen/FavoriteSongList/favoriteSongList.dart';
import 'package:musicPlayer/screen/MusicPlayer/MusicPlayerScreen.dart';
import 'package:musicPlayer/screen/account/account.dart';
import 'package:musicPlayer/screen/home/HomeMain.dart';
import 'package:musicPlayer/widgets/nowPlayingMin.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  PageController pageController;
  int pageIndex = 0;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    super.initState();
    pageController = PageController();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.getToken().then((String token) {
      print(token);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  onPageChanged(int pageIndex) {
    setState(() {
      this.pageIndex = pageIndex;
    });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          HomeScreen(),
          Favorite(),
          AccountScreen(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar:
          CupertinoTabBar(currentIndex: pageIndex, onTap: onTap, items: [
        BottomNavigationBarItem(icon: Icon(Icons.audiotrack), label: "EXPLORE"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "FAVORITE"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "ACCOUNT"),
      ]),
      bottomSheet: pageIndex != 1 ? NowPlayingMinPlayer() : Text(""),
    );
  }
}
