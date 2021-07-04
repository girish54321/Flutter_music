import 'dart:io';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:musicPlayer/responsive/enums/device_screen_type.dart';
import 'package:musicPlayer/responsive/utils/ui_utils.dart';
import 'package:page_transition/page_transition.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Helper {
  getMobileOrientation(context) {
    int cellCount = 2;
    var mediaQuery = MediaQuery.of(context);
    DeviceScreenType deviceScreenType = getDeviceType(mediaQuery);
    var orientation = mediaQuery.orientation;
    if (deviceScreenType == DeviceScreenType.Mobile) {
      cellCount = orientation == Orientation.portrait ? 2 : 4;
    } else if (deviceScreenType == DeviceScreenType.Tablet) {
      cellCount = 4;
    } else if (deviceScreenType == DeviceScreenType.Desktop) {
      cellCount = responsiveNumGridTiles(mediaQuery);
    }
    return cellCount;
  }

  int responsiveNumGridTiles(MediaQueryData mediaQuery) {
    double deviceWidth = mediaQuery.size.width;
    if (deviceWidth < 700) {
      return 3;
    } else if (deviceWidth < 1200) {
      return 5;
    } else if (deviceWidth < 1650) {
      return 8;
    } else {
      return 8;
    }
  }

  showToastMessage(message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  showLoadingDilog(context) {
    ProgressDialog pr = ProgressDialog(context);
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false, showLogs: false);
    pr.style(
        message: 'Loading..',
        padding: EdgeInsets.all(16.0),
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: Container(
            padding: EdgeInsets.all(8.0), child: CircularProgressIndicator()),
        elevation: 6.0,
        insetAnimCurve: Curves.easeInOut,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 19.0,
          fontWeight: FontWeight.w600,
        ));
    return pr;
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

  Duration parseDuration(String s) {
    int hours = 0;
    int minutes = 0;
    int micros;
    List<String> parts = s.split(':');
    if (parts.length > 2) {
      hours = int.parse(parts[parts.length - 3]);
    }
    if (parts.length > 1) {
      minutes = int.parse(parts[parts.length - 2]);
    }
    micros = (double.parse(parts[parts.length - 1]) * 1000000).round();
    return Duration(hours: hours, minutes: minutes, microseconds: micros);
  }

  goToPage(
    BuildContext context,
    Widget child,
    bool hasHeroTag,
  ) {
    if (Platform.isIOS || hasHeroTag) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => child,
        ),
      );
    } else {
      Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: child,
          ));
    }
  }
}
