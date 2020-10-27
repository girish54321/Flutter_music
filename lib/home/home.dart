import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicPlayer/MisicPlayer/MusicPlayerScreen.dart';
import 'package:musicPlayer/account/account.dart';
import 'package:musicPlayer/animasions/rightToLeft.dart';
import 'package:musicPlayer/home/HomeScreen.dart';
import 'package:musicPlayer/screen/Favorite/favorite.dart';
import 'package:musicPlayer/search/search.dart';
import 'package:musicPlayer/widgets/nowPlayingMin.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
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
          SearchScreen(),
          BGAudioPlayerScreen(),
          Favorite(),
          AccountScreen(),
        ],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: CupertinoTabBar(
          currentIndex: pageIndex,
          onTap: onTap,
          activeColor: Theme.of(context).primaryColor,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.audiotrack), label: "EXPLORE"),
            BottomNavigationBarItem(
                icon: Icon(Icons.whatshot), label: "TRENDING"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.play_circle_filled,
                ),
                label: "PLAYER"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "FAVORITE"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "SETTINGS"),
          ]),
      bottomSheet: pageIndex != 2 ? NowPlayingMinPlayer() : Text(""),
    );
  }
}
