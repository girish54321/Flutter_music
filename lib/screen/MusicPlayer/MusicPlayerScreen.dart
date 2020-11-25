import 'dart:math';

import 'package:audio_service/audio_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicPlayer/helper/helper.dart';
import 'package:musicPlayer/modal/player_song_list.dart';
import 'package:musicPlayer/screen/MusicPlayer/MusicPlayerExtraControl.dart';
import 'package:musicPlayer/screen/SingerProfile/singerProfile.dart';
import 'package:musicPlayer/screen/imageViewScreen/imageViewScreen.dart';
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
    print("IMAGE");
    // print(widget.nowPlayingClass[0].imageUrl);
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
        print("now playong" + widget.nowPlayingClass[0].name);
        await AudioService.addQueueItem(mediaItem);
      }
    } else {
      print("not runing");
      print("New Player" + widget.nowPlayingClass.length.toString());
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
      } else {}
    }
  }

  Widget coverArt(MediaItem mediaItem) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: ImageViewScreen(
                        imageUrl: mediaItem.artUri, heroTag: "heroTag")));
          },
          child: Hero(
            tag: "heroTag",
            child: CachedNetworkImage(
              imageUrl: mediaItem.artUri,
              imageBuilder: (context, imageProvider) => Container(
                height: 290.00,
                width: 290.00,
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Theme.of(context).accentColor,
                      blurRadius: 5.0,
                    ),
                  ],
                  image:
                      DecorationImage(image: imageProvider, fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20.00),
                ),
              ),
              placeholder: (context, url) => Container(
                height: 290.00,
                width: 290.00,
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 40.0,
                    ),
                  ],
                  image: DecorationImage(
                      image: AssetImage('assets/images/placholder.jpg'),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20.00),
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
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
            child: Text(
              title != null ? title : "",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
                fontSize: 22,
                color: Color(0xff000000),
              ),
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
                    coverArt(mediaItem),
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
    // print(mediaItem);
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
                      Helper().printDuration(state.currentPosition),
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
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
