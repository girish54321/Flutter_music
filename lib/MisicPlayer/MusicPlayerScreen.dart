import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicPlayer/MisicPlayer/MusicPlayerExtraControl.dart';
import 'package:musicPlayer/modal/player_song_list.dart';
import 'package:musicPlayer/network_utils/api.dart';
import 'package:musicPlayer/screen/articesProfile/singerProfile.dart';
import 'package:musicPlayer/widgets/allText/AppText.dart';
import 'package:musicPlayer/widgets/nowPlayingMin.dart';
import 'package:page_transition/page_transition.dart';
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

class _BGAudioPlayerScreenState extends State<BGAudioPlayerScreen> {
  final BehaviorSubject<double> _dragPositionSubject =
      BehaviorSubject.seeded(null);

  List<MediaItem> nowPlaying = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    // _loading = false;
    playInComingTrack();
  }

  playInComingTrack() async {
    print("HEHHEHH1111E");
    print(widget.nowPlayingClass[0].imageUrl);
    if (AudioService.running) {
      if (widget.nowPlayingClass != null) {
        var listItem = widget.nowPlayingClass[0];
        Map<String, dynamic> nowPlayingSinger = {
          "name": listItem.name,
          "songId": listItem.songId,
          "singerId": listItem.singerId,
          "imageUrl": listItem.imageUrl.replaceAll("large", "t500x500"),
          "fav": listItem.fav,
          "audio_url":listItem.audio_url
        };
        print(nowPlayingSinger);
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
        print("ADDEDEDED");
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
            "audio_url":listItem.audio_url
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
        print(params);
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
      } else {
        print("NOw data in pao");
      }
    }
  }

  Widget coverArt(MediaItem mediaItem) {
    return Column(
      children: <Widget>[
        Center(
            child: Container(
          height: 290.00,
          width: 290.00,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  mediaItem.artUri.replaceAll("large", "t300x300")),
            ),
            borderRadius: BorderRadius.circular(20.00),
          ),
        )),
        singerName(mediaItem.artist, mediaItem.title, mediaItem.extras),
      ],
    );
  }

  Widget singerName(name, title, extras) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 18,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 26),
          child: Center(
            child: Headline3(
              text: title != null ? title : "",
            ),
          ),
        ),
        Center(
            child: FlatButton(
          child: LargeBody(
            text: name != null ? name : "",
          ),
          onPressed: () {},
        )),
      ],
    );
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
            height: 70.00,
            width: 70.00,
            decoration: BoxDecoration(
              color: Color(0xffff2d55),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: playing ? AudioService.pause : AudioService.play,
              icon: Icon(
                playing ? Icons.pause : Icons.play_arrow,
                size: 40,
                color: Colors.white,
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
                // imageUrl: https://i1.sndcdn.com/avatars-000463172286-f7nnhe-large.jpg, name: Distant.lo, fav: 1, songId: 25175318
                // mediaItem.extras['imageUrl']
                print("extras");
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
                print(mediaItem.extras);
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child:
                            SingerProgile(nowPlayingClass: nowPlayingClass)));
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
      // backgroundColor: Theme.of(context).accentColor,
      body: SafeArea(
        child: StreamBuilder<AudioState>(
          stream: _audioStateStream,
          builder: (context, snapshot) {
            final audioState = snapshot.data;
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
                    coverArt(mediaItem),
                    positionIndicator(mediaItem, playbackState),
                    playerContalors(playing),
                    // SizedBox(height: 11),
                    // extraContorl(mediaItem)
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
    // print(mediaItem);
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
        return Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (duration != null)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Slider(
                    activeColor: Theme.of(context).accentColor,
                    inactiveColor: Colors.grey.shade300,
                    min: 0.0,
                    max: duration,
                    value: seekPos ?? max(0.0, min(position, duration)),
                    onChanged: (value) {
                      _dragPositionSubject.add(value);
                    },
                    onChangeEnd: (value) {
                      AudioService.seekTo(
                          Duration(milliseconds: value.toInt()));
                      seekPos = value;
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
                      Network().printDuration(state.currentPosition),
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor),
                    ),
                    Text(
                      Network().printDuration(mediaItem.duration),
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
