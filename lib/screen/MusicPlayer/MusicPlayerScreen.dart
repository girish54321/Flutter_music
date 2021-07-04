import 'dart:math';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicPlayer/helper/helper.dart';
import 'package:musicPlayer/modal/player_song_list.dart';
import 'package:musicPlayer/screen/MusicPlayer/MusicPlayerExtraControl.dart';
import 'package:musicPlayer/screen/SingerProfile/singerProfile.dart';
import 'package:musicPlayer/screen/MusicPlayer/coverArt.dart';
import 'package:musicPlayer/widgets/nowPlayingMin.dart';
import 'package:rxdart/rxdart.dart';
import 'AudioPlayer.dart';

class BGAudioPlayerScreen extends StatefulWidget {
  final List<NowPlayingClass> nowPlayingClass;

  const BGAudioPlayerScreen({
    Key key,
    this.nowPlayingClass,
  }) : super(key: key);

  @override
  _BGAudioPlayerScreenState createState() => _BGAudioPlayerScreenState();
}

class _BGAudioPlayerScreenState extends State<BGAudioPlayerScreen>
    with TickerProviderStateMixin {
  final BehaviorSubject<double> _dragPositionSubject =
      BehaviorSubject.seeded(null);

  List<MediaItem> nowPlaying = [];
  bool _loading = false;
  AnimationController _animationController;

  @override
  void initState() {
    playInComingTrack();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animationController.forward();
    super.initState();
  }

  playInComingTrack() async {
    if (AudioService.running) {
      if (widget.nowPlayingClass != null) {
        var listItem = widget.nowPlayingClass[0];
        Map<String, dynamic> nowPlayingSinger = {
          "name": listItem.name,
          "songId": listItem.songId,
          "singerId": listItem.singerId,
          "imageUrl": listItem.imageUrl.replaceAll("large", "t500x500"),
          "fav": listItem.fav,
          "audio_url": listItem.audio_url
        };
        MediaItem mediaItem = new MediaItem(
            id: listItem.url,
            title: listItem.title,
            artist: listItem.artist,
            artUri: listItem.artUri.replaceAll("large", "t500x500"),
            album: listItem.album,
            duration: listItem.duration,
            extras: nowPlayingSinger);
        Future.delayed(Duration(seconds: 5));

        await AudioService.addQueueItem(mediaItem);
      }
    } else {
      if (widget.nowPlayingClass != null) {
        for (int i = 0; i < widget.nowPlayingClass.length; i++) {
          var listItem = widget.nowPlayingClass[i];
          Map<String, dynamic> nowPlayingSinger = {
            "name": listItem.name,
            "songId": listItem.songId,
            "singerId": listItem.singerId,
            "imageUrl": listItem.imageUrl,
            "fav": listItem.fav,
            "audio_url": listItem.audio_url
          };
          MediaItem mediaItem = new MediaItem(
              id: listItem.url,
              title: listItem.title,
              artist: listItem.artist,
              artUri: listItem.artUri.replaceAll("large", "t500x500"),
              album: listItem.album,
              duration: listItem.duration,
              extras: nowPlayingSinger);
          setState(() {
            nowPlaying.add(mediaItem);
          });
        }
        setState(() {});
        List<dynamic> list = List();
        for (int i = 0; i < nowPlaying.length; i++) {
          var m = nowPlaying[i].toJson();
          list.add(m);
        }
        var params = {"data": list};
        setState(() {
          _loading = true;
        });
        await AudioService.start(
          androidEnableQueue: true,
          backgroundTaskEntrypoint: _audioPlayerTaskEntrypoint,
          androidNotificationChannelName: 'Audio Player',
          androidNotificationColor: 0xFF2196f3,
          androidNotificationIcon: 'mipmap/launcher_icon',
          params: params,
        );

        setState(() {
          _loading = false;
        });
      } else {}
    }
  }

  Widget playerContalors(playing) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 38),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            Icons.replay_30,
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
            height: 60.00,
            width: 60.00,
            decoration: BoxDecoration(
              color: Color(0xffff2d55),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {
                if (playing) {
                  _animationController.reverse();
                  AudioService.pause();
                } else {
                  _animationController.forward();
                  AudioService.play();
                }
              },
              icon: AnimatedIcon(
                size: 40,
                icon: AnimatedIcons.play_pause,
                color: Colors.white,
                progress: _animationController,
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
            Icons.forward_30,
            size: 36,
          ),
        ],
      ),
    );
  }

  Widget extraContorl(MediaItem mediaItem) {
    return Padding(
      // padding: EdgeInsets.symmetric(horizontal: 28),
      padding: EdgeInsets.only(left: 33, right: 33, bottom: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              icon: Icon(
                Icons.favorite,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.swap_horiz,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.account_circle,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {
                NowPlayingClass nowPlayingClass = new NowPlayingClass(
                  mediaItem.id,
                  mediaItem.title,
                  mediaItem.artist,
                  mediaItem.artUri,
                  null,
                  mediaItem.duration,
                  mediaItem.artist,
                  mediaItem.extras['songId'],
                  mediaItem.extras['singerId'],
                  mediaItem.extras['imageUrl'],
                  mediaItem.extras['fav'],
                  mediaItem.extras['audio_url'],
                );
                Helper().goToPage(context,
                    SingerProgile(nowPlayingClass: nowPlayingClass), false);
              }),
          IconButton(
              icon: Icon(
                Icons.queue_music,
              ),
              onPressed: () {})
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Music Player"),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: StreamBuilder<AudioState>(
          stream: _audioStateStream,
          builder: (context, snapshot) {
            final audioState = snapshot.data;
            // ignore: unused_local_variable
            final queue = audioState?.queue;
            final mediaItem = audioState?.mediaItem;
            final playbackState = audioState?.playbackState;
            final processingState =
                playbackState?.processingState ?? AudioProcessingState.none;
            final playing = playbackState?.playing ?? false;
            return Container(
              // width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (processingState == AudioProcessingState.none) ...[
                    _startAudioPlayerBtn(),
                  ] else ...[
                    SizedBox(height: 14),
                    CoverArt(
                      mediaItem: mediaItem,
                    ),
                    positionIndicator(mediaItem, playbackState),
                    playerContalors(playing),
                    ExtrarContols(mediaItem: mediaItem)
                  ]
                ],
              ),
            );
          },
        ),
      ),
      bottomSheet: PlayButton(
        startPlayBackUp: _startMusicButton,
      ),
    );
  }

  _startMusicButton() async {
    List<dynamic> list = List();
    for (int i = 0; i < 2; i++) {
      var m = nowPlaying[i].toJson();
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
      var m = nowPlaying[i].toJson();
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

  Widget positionIndicator(MediaItem mediaItem, PlaybackState state) {
    double seekPos;
    // ignore: unused_local_variable
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
        // ignore: unused_local_variable
        final player = AudioPlayer();
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (duration != null)
                Padding(
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
                      _dragPositionSubject.add(null);
                    },
                  ),
                ),
              Padding(
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
