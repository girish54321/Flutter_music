import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import '../helper/helper.dart';
import 'dart:math';

class PositionIndicator extends StatelessWidget {
  final MediaItem mediaItem;
  final PlaybackState state;
  final BehaviorSubject<double> dragPositionSubject;
  final bool smallView;
  const PositionIndicator(
      {Key key,
      @required this.mediaItem,
      @required this.state,
      this.dragPositionSubject,
      @required this.smallView})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double seekPos;
    // ignore: unused_local_variable
    Duration length;
    return StreamBuilder(
      stream: Rx.combineLatest2<double, double, double>(
          dragPositionSubject.stream,
          Stream.periodic(Duration(milliseconds: 200)),
          (dragPosition, _) => dragPosition),
      builder: (context, snapshot) {
        double position =
            snapshot.data ?? state.currentPosition.inMilliseconds.toDouble();
        double duration = mediaItem?.duration?.inMilliseconds?.toDouble();
        // ignore: unused_local_variable
        final player = AudioPlayer();
        return Container(
          alignment: Alignment.centerLeft,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (duration != null)
                smallView
                    ? Container(
                        height: 2,
                        width: position / duration * 410,
                        color: Colors.red,
                        alignment: Alignment.centerLeft,
                      )
                    : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18),
                        child: FlutterSlider(
                          tooltip: FlutterSliderTooltip(disabled: true),
                          handler: FlutterSliderHandler(child: Text("")),
                          trackBar: FlutterSliderTrackBar(
                              inactiveTrackBar:
                                  BoxDecoration(color: Colors.grey.shade300),
                              activeTrackBar: BoxDecoration(
                                  color: Theme.of(context).accentColor)),
                          values: [
                            seekPos ?? max(0.0, min(position, duration)),
                          ],
                          max: duration,
                          min: 0.0,
                          onDragging: (handlerIndex, lowerValue, upperValue) {
                            AudioService.seekTo(
                                Duration(milliseconds: lowerValue.toInt()));
                            seekPos = lowerValue;
                            dragPositionSubject.add(null);
                          },
                        ),
                      ),
              smallView
                  ? SizedBox(
                      height: 0,
                    )
                  : Padding(
                      padding: EdgeInsets.symmetric(horizontal: 38),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            Helper().printDuration(state.currentPosition),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Theme.of(context).accentColor),
                          ),
                          Text(
                            Helper().printDuration(mediaItem.duration),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).accentColor),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}
