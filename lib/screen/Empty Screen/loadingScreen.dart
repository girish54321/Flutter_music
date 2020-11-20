import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GlowingProgressIndicator(
        child: Icon(
          Icons.headset_rounded,
          size: 77,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }
}
