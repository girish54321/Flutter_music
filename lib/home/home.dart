import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musicPlayer/MisicPlayer/MusicPlayerScreen.dart';
import 'package:musicPlayer/account/account.dart';
import 'package:musicPlayer/home/HomeScreen.dart';
import 'package:musicPlayer/search/search.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
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
      key: _scaffoldKey,
      body: PageView(
        children: <Widget>[
          HomeScreen(),
          SearchScreen(),
          BGAudioPlayerScreen(),
          AccountScreen(),
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
            BottomNavigationBarItem(icon: Icon(Icons.home)),
            BottomNavigationBarItem(icon: Icon(Icons.notifications)),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.play_circle_filled,
                size: 44,
              ),
            ),
            BottomNavigationBarItem(icon: Icon(Icons.search)),
            BottomNavigationBarItem(icon: Icon(Icons.person)),
          ]),
      // bottomSheet: pageIndex != 2 ? NowPlaying() : Text(""),
    );
  }
}
