import 'package:audio_service/audio_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:musicPlayer/provider/Fav_list.dart';
import 'package:musicPlayer/provider/RecentlyPlayedProvider.dart';
import 'package:musicPlayer/provider/loginState.dart';
import 'package:musicPlayer/screen/auth/loginScreen/login.dart';
import 'package:musicPlayer/screen/home/home.dart';
import 'package:provider/provider.dart';
import 'package:musicPlayer/helper/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RecentlyPlayedProvider>(
            create: (context) => RecentlyPlayedProvider()),
        ChangeNotifierProvider<FavListProvider>(
            create: (context) => FavListProvider()),
        ChangeNotifierProvider<LoginStateProvider>(
            create: (context) => LoginStateProvider()),
        ChangeNotifierProvider<ThemeNotifier>(
            create: (context) => ThemeNotifier()),
      ],
      child: Consumer<LoginStateProvider>(
        builder: (context, loginStateProvider, child) {
          return Consumer<ThemeNotifier>(
            builder: (context, ThemeNotifier notifier, child) {
              return MaterialApp(
                  theme: notifier.darkTheme ? dark : light,
                  title: 'Music Players',
                  home: loginStateProvider.logedIn == true
                      ? AudioServiceWidget(child: MyHomePage())
                      : LoginScreen());
            },
          );
        },
      ),
    );
  }
}
