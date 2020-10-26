import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:musicPlayer/MisicPlayer/AudioPlayer.dart';
import 'package:musicPlayer/MisicPlayer/MusicPlayerScreen.dart';
import 'package:musicPlayer/widgets/allText/AppText.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rxdart/rxdart.dart';
import 'package:audio_service/audio_service.dart';

class NowPlayingMinPlayer extends StatelessWidget {
  const NowPlayingMinPlayer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ContainerTransitionType _transitionType = ContainerTransitionType.fade;
    return StreamBuilder<AudioState>(
      stream: _audioStateStream,
      builder: (context, snapshot) {
        final audioState = snapshot.data;
        final playbackState = audioState?.playbackState;
        final mediaItem = audioState?.mediaItem;
        final processingState =
            playbackState?.processingState ?? AudioProcessingState.none;
        final playing = playbackState?.playing ?? false;
        return Container(
          height: processingState == AudioProcessingState.none ? 1.0 : 72.00,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              if (processingState == AudioProcessingState.none) ...[
                Text("Not Playing")
              ] else ...[
                Container(
                  // height: 55.00,
                  width: double.infinity,
                  color: Color(0xfff9f9f9),
                  child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.bottomToTop,
                                child: BGAudioPlayerScreen()));
                      },
                      title: Headline5(text: mediaItem.title),
                      subtitle: CaptionL(text: mediaItem.artist),
                      leading: Container(
                        height: 54.00,
                        width: 54.00,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(mediaItem.artUri
                                  .replaceAll("large", "t300x300")),
                              fit: BoxFit.cover),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0.00, 3.00),
                              color: Color(0xff00a650).withOpacity(0.30),
                              blurRadius: 26,
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15.00),
                        ),
                      ),
                      trailing: IconButton(
                          icon: new Icon(
                            playing ? Icons.pause : Icons.play_arrow,
                            color: Colors.black,
                          ),
                          onPressed: playing
                              ? AudioService.pause
                              : AudioService.play)),
                )
              ]
            ],
          ),
        );
      },
    );
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
}

class PlayButton extends StatelessWidget {
  final Function startPlayBackUp;
  const PlayButton({Key key, this.startPlayBackUp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AudioState>(
      stream: _audioStateStream,
      builder: (context, snapshot) {
        final audioState = snapshot.data;
        final playbackState = audioState?.playbackState;
        final processingState =
            playbackState?.processingState ?? AudioProcessingState.none;
        final playing = playbackState?.playing ?? false;
        return processingState == AudioProcessingState.none
            ? Center(
                child: FloatingActionButton(
                  onPressed: () {
                    startPlayBackUp();
                  },
                  backgroundColor: Colors.deepPurple,
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              )
            : Container(height: 0, color: Colors.white // This is optional
                );
      },
    );
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
}