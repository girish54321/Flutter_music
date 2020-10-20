import 'package:flutter/material.dart';
import 'package:musicPlayer/MisicPlayer/AudioPlayer.dart';
import 'package:rxdart/rxdart.dart';
import 'package:audio_service/audio_service.dart';

class NowPlaying extends StatelessWidget {
  const NowPlaying({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).accentColor,
      height: 33,
      child: StreamBuilder<AudioState>(
        stream: _audioStateStream,
        builder: (context, snapshot) {
          final audioState = snapshot.data;
          final playbackState = audioState?.playbackState;
          final processingState =
              playbackState?.processingState ?? AudioProcessingState.none;
          final playing = playbackState?.playing ?? false;
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                if (processingState == AudioProcessingState.none) ...[
                  Text("Not Playing")
                ] else ...[
                  Text("Playing")
                ]
              ],
            ),
          );
        },
      ),
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
