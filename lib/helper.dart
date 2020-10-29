import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musicPlayer/database/dataBaseHelper/Recently_played.dart';
import 'package:musicPlayer/modal/player_song_list.dart';

class Helper {
  showToastMessage(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  showSnackBar(message, title, context, bool error) {
    return Flushbar(
      title: title,
      message: message,
      backgroundColor: error ? Colors.orange : Theme.of(context).accentColor,
      reverseAnimationCurve: Curves.easeIn,
      forwardAnimationCurve: Curves.easeInOut,
      duration: Duration(seconds: 5),
      margin: EdgeInsets.all(8),
      borderRadius: 8,
    )..show(context);
  }

  printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
