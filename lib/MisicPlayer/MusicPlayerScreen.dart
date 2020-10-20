import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicPlayer/widgets/header.dart';
import 'package:musicPlayer/widgets/nowPlaying.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simple_animations/simple_animations.dart';
import 'AudioPlayer.dart';

class BGAudioPlayerScreen extends StatefulWidget {
  @override
  _BGAudioPlayerScreenState createState() => _BGAudioPlayerScreenState();
}

class _BGAudioPlayerScreenState extends State<BGAudioPlayerScreen> {
  final BehaviorSubject<double> _dragPositionSubject =
      BehaviorSubject.seeded(null);

  final _queue = <MediaItem>[
    MediaItem(
      id: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
      title: "SoundHelix Song 1",
      artist: "T. Schürger",
      artUri:
          "https://i.pinimg.com/originals/3d/fc/ed/3dfced4a6e2994f536477b071d283a23.jpg",
      album: null,
      duration: Duration(milliseconds: 5739820),
    ),
    MediaItem(
      id: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3",
      title: "SoundHelix Song 2",
      artist: "T. Schürger",
      artUri:
          "https://i.pinimg.com/originals/3d/fc/ed/3dfced4a6e2994f536477b071d283a23.jpg",
      album: null,
      duration: Duration(milliseconds: 5739820),
    ),
  ];

  bool _loading;

  @override
  void initState() {
    super.initState();
    _loading = false;
  }

  Widget coverArt(MediaItem mediaItem) {
    return Column(
      children: <Widget>[
        Center(
          child: Container(
            height: 260,
            width: 260,
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(200)),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(200),
              child: Image.network(
                mediaItem.artUri,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        singerName(mediaItem.artist, mediaItem.title),
      ],
    );
  }

  Widget singerName(name, title) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            name,
            style: TextStyle(fontSize: 15, color: Colors.grey.shade700),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  Widget playerContalors(playing) {
    return (Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            Icons.repeat,
            size: 36,
          ),
          IconButton(
            icon: Icon(
              Icons.skip_previous,
              size: 36,
            ),
            onPressed: AudioService.skipToPrevious,
          ),
          Container(
            height: 60,
            width: 60,
            child: FloatingActionButton(
              onPressed: playing ? AudioService.pause : AudioService.play,
              backgroundColor: Colors.deepPurple,
              child: Icon(
                playing ? Icons.plus_one : Icons.play_arrow,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          IconButton(
              icon: Icon(
                Icons.skip_next,
                size: 36,
              ),
              onPressed: AudioService.skipToNext),
          Icon(
            Icons.shuffle,
            size: 36,
          ),
        ],
      ),
    ));
  }

  Widget coverArtAnimastion(mediaItem) {
    // ignore: deprecated_member_use
    return ControlledAnimation(
      duration: Duration(milliseconds: 600),
      curve: Curves.elasticOut,
      tween: Tween<double>(begin: 0, end: 1),
      builder: (context, scaleValue) {
        return Transform.scale(
          scale: scaleValue,
          alignment: Alignment.center,
          child: coverArt(mediaItem),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Header(context, "Now Playing"),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 19),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: Center(
                child: StreamBuilder<AudioState>(
                  stream: _audioStateStream,
                  builder: (context, snapshot) {
                    final audioState = snapshot.data;
                    final queue = audioState?.queue;
                    final mediaItem = audioState?.mediaItem;
                    final playbackState = audioState?.playbackState;
                    final processingState = playbackState?.processingState ??
                        AudioProcessingState.none;
                    final playing = playbackState?.playing ?? false;
                    return Container(
                      // width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          if (processingState == AudioProcessingState.none) ...[
                            _startAudioPlayerBtn(),
                          ] else ...[
                            SizedBox(
                              height: 12,
                            ),
                            SizedBox(
                              height: 19,
                            ),
                            coverArtAnimastion(mediaItem),
                            positionIndicator(mediaItem, playbackState),
                            playerContalors(playing),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     !playing
                            //         ? IconButton(
                            //             icon: Icon(Icons.play_arrow),
                            //             iconSize: 64.0,
                            //             onPressed: AudioService.play,
                            //           )
                            //         : IconButton(
                            //             icon: Icon(Icons.pause),
                            //             iconSize: 64.0,
                            //             onPressed: AudioService.pause,
                            //           ),
                            //     IconButton(
                            //       icon: Icon(Icons.stop),
                            //       iconSize: 64.0,
                            //       onPressed: AudioService.stop,
                            //     ),
                            //     Row(
                            //       mainAxisAlignment: MainAxisAlignment.center,
                            //       children: [
                            //         IconButton(
                            //           icon: Icon(Icons.skip_previous),
                            //           iconSize: 64,
                            //           onPressed: () {
                            //             if (mediaItem == queue.first) {
                            //               return;
                            //             }
                            //             AudioService.skipToPrevious();
                            //           },
                            //         ),
                            //         IconButton(
                            //           icon: Icon(Icons.skip_next),
                            //           iconSize: 64,
                            //           onPressed: () {
                            //             if (mediaItem == queue.last) {
                            //               return;
                            //             }
                            //             AudioService.skipToNext();
                            //           },
                            //         )
                            //       ],
                            //     ),
                            //   ],
                            // )
                          ]
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: PlayButton(
        startPlayBackUp: _startMusicButton,
      ),
    );
  }

  _startMusicButton() async {
    List<dynamic> list = List();
    for (int i = 0; i < 2; i++) {
      var m = _queue[i].toJson();
      list.add(m);
    }
    var params = {"data": list};
    setState(() {
      _loading = true;
    });
    await AudioService.start(
      backgroundTaskEntrypoint: _audioPlayerTaskEntrypoint,
      androidNotificationChannelName: 'Audio Player',
      androidNotificationColor: 0xFF2196f3,
      androidNotificationIcon: 'mipmap/ic_launcher',
      params: params,
    );
    setState(() {
      _loading = false;
    });
  }

  _startAudioPlayerBtn() {
    List<dynamic> list = List();
    for (int i = 0; i < 2; i++) {
      var m = _queue[i].toJson();
      list.add(m);
    }
    var params = {"data": list};
    return MaterialButton(
      child: Text(_loading ? "Loading..." : 'Start Audio Player'),
      onPressed: () async {
        setState(() {
          _loading = true;
        });

        await AudioService.start(
          backgroundTaskEntrypoint: _audioPlayerTaskEntrypoint,
          androidNotificationChannelName: 'Audio Player',
          androidNotificationColor: 0xFF2196f3,
          androidNotificationIcon: 'mipmap/ic_launcher',
          params: params,
        );
        setState(() {
          _loading = false;
        });
      },
    );
  }

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  Widget positionIndicator(MediaItem mediaItem, PlaybackState state) {
    double seekPos;
    print(mediaItem);
    Duration length;
    return StreamBuilder(
      stream: Rx.combineLatest2<double, double, double>(
          _dragPositionSubject.stream,
          Stream.periodic(Duration(milliseconds: 200)),
          (dragPosition, _) => dragPosition),
      builder: (context, snapshot) {
        double position =
            snapshot.data ?? state.currentPosition.inMilliseconds.toDouble();
        double duration = mediaItem?.duration?.inMilliseconds?.toDouble();
        final player = AudioPlayer();
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    _printDuration(state.currentPosition),
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    _printDuration(mediaItem.duration),
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            if (duration != null)
              Slider(
                activeColor: Colors.red,
                inactiveColor: Colors.grey.shade300,
                min: 0.0,
                max: duration,
                value: seekPos ?? max(0.0, min(position, duration)),
                onChanged: (value) {
                  _dragPositionSubject.add(value);
                },
                onChangeEnd: (value) {
                  AudioService.seekTo(Duration(milliseconds: value.toInt()));
                  seekPos = value;
                  _dragPositionSubject.add(null);
                },
              ),
            SizedBox(
              height: 40,
            ),
          ],
        );
      },
    );
  }
}

Stream<AudioState> get _audioStateStream {
  return Rx.combineLatest3<List<MediaItem>, MediaItem, PlaybackState,
      AudioState>(
    AudioService.queueStream,
    AudioService.currentMediaItemStream,
    AudioService.playbackStateStream,
    (queue, mediaItem, playbackState) => AudioState(
      queue,
      mediaItem,
      playbackState,
    ),
  );
}

void _audioPlayerTaskEntrypoint() async {
  AudioServiceBackground.run(() => AudioPlayerTask());
}
