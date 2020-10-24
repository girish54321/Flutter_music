import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicPlayer/articesProfile/singerProfile.dart';
import 'package:musicPlayer/modal/player_song_list.dart';
import 'package:musicPlayer/widgets/allText/AppText.dart';
import 'package:musicPlayer/widgets/appNetWorkImage.dart';
import 'package:musicPlayer/widgets/header.dart';
import 'package:musicPlayer/widgets/nowPlaying.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rxdart/rxdart.dart';
import 'package:simple_animations/simple_animations.dart';
import 'AudioPlayer.dart';
import 'package:musicPlayer/modal/playListResponse.dart' as playList;
import 'package:color_thief_flutter/color_thief_flutter.dart';
import 'package:color_thief_flutter/utils.dart';

class BGAudioPlayerScreen extends StatefulWidget {
  final List<NowPlayingClass> nowPlayingClass;
  final playList.Track track;
  const BGAudioPlayerScreen({Key key, this.nowPlayingClass, this.track})
      : super(key: key);

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
    if (AudioService.running) {
      if (widget.nowPlayingClass != null) {
        var listItem = widget.nowPlayingClass[0];
        MediaItem mediaItem = new MediaItem(
            id: listItem.url,
            title: listItem.title,
            artist: listItem.artist,
            artUri: listItem.artUri.replaceAll("large", "t500x500"),
            album: listItem.album,
            duration: listItem.duration);
        print(listItem.title);
        print("ADDED IN LISt");

        Future.delayed(Duration(seconds: 5));
        Fluttertoast.showToast(
            msg: "Added To PlayList",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.orange,
            textColor: Colors.white,
            fontSize: 16.0);
        await AudioService.addQueueItem(mediaItem);
      }
    } else {
      if (widget.nowPlayingClass != null) {
        for (int i = 0; i < widget.nowPlayingClass.length; i++) {
          print("HEHHEHHEssssssssssss");
          var listItem = widget.nowPlayingClass[i];
          MediaItem mediaItem = new MediaItem(
              id: listItem.url,
              title: listItem.title,
              artist: listItem.artist,
              artUri: listItem.artUri.replaceAll("large", "t500x500"),
              album: listItem.album,
              duration: listItem.duration);
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

  // @override
  // void onAddQueueItem(MediaItem mediaItem) {
  //   super.onAddQueueItem(mediaItem);
  //   nowPlaying.add(mediaItem);
  //   AudioServiceBackground.setQueue(nowPlaying);
  // }

  Widget coverArt(MediaItem mediaItem) {
    // var color = [90, 90, 90];
    // getColorFromUrl(mediaItem.artUri.replaceAll("large", "t300x300"))
    //     .then((color) {
    //   print(color); // [R,G,B]
    //   print("// [R,G,B]");
    //   color = color;
    //   // if()
    //   // setState(() {});
    // });
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
            boxShadow: [
              BoxShadow(
                offset: Offset(0.00, 3.00),
                color: Colors.black,
                // color: Color.fromRGBO(color[0], color[1], color[2], 1),
                blurRadius: 26,
              ),
            ],
          ),
        )),
        singerName(mediaItem.artist, mediaItem.title),
      ],
    );
  }

  Widget singerName(name, title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: 22,
        ),
        Center(
          child: Headline3(
            text: title != null ? title : "",
          ),
        ),
        Center(
            child: FlatButton(
          child: LargeBody(
            text: name != null ? name : "",
          ),
          onPressed: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: SingerProgile(track: widget.track)));
          },
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

  // Widget coverArtAnimastion(mediaItem) {
  //   // ignore: deprecated_member_use
  //   return ControlledAnimation(
  //     duration: Duration(milliseconds: 600),
  //     curve: Curves.elasticOut,
  //     tween: Tween<double>(begin: 0, end: 1),
  //     builder: (context, scaleValue) {
  //       return Transform.scale(
  //         scale: scaleValue,
  //         alignment: Alignment.center,
  //         child: coverArt(mediaItem),
  //       );
  //     },
  //   );
  // }

  Widget nowPlayingToolBar(title) {
    return (Container(
      child: ListTile(
        title: Text(
          "NOW PLAYING FROM",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            fontSize: 13,
            color: Color(0xff000000).withOpacity(0.60),
          ),
        ),
        subtitle: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Poppins",
            fontWeight: FontWeight.w600,
            fontSize: 17,
            color: Color(0xffff2d55),
          ),
        ),
        trailing: IconButton(
            icon: new Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onPressed: () {
              // Navigator.pop(context);
            }),
        leading: IconButton(
            icon: new Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
    ));
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
                    //  nowPlayingToolBar(""),
                    _startAudioPlayerBtn(),
                  ] else ...[
                    // nowPlayingToolBar(mediaItem.artist),
                    SizedBox(height: 14),
                    coverArt(mediaItem),
                    positionIndicator(mediaItem, playbackState),
                    playerContalors(playing),
                    SizedBox(height: 14)
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

  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
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
                      _printDuration(state.currentPosition),
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).accentColor),
                    ),
                    Text(
                      _printDuration(mediaItem.duration),
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
