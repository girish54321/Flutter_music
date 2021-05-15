import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:musicPlayer/helper/helper.dart';
import 'package:musicPlayer/screen/MusicPlayer/AudioPlayer.dart';
import 'package:musicPlayer/screen/MusicPlayer/MusicPlayerScreen.dart';
import 'package:musicPlayer/widgets/allText/AppText.dart';
import 'package:rxdart/rxdart.dart';
import 'package:audio_service/audio_service.dart';

class NowPlayingMinPlayer extends StatelessWidget {
  const NowPlayingMinPlayer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          height: processingState == AudioProcessingState.none ? 1.0 : 74.00,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              if (processingState == AudioProcessingState.none) ...[
                Text("Not Playing")
              ] else ...[
                Container(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        height: 2,
                        color: Colors.red,
                      ),
                      ListTile(
                          onTap: () {
                            Helper().goToPage(context, BGAudioPlayerScreen());
                          },
                          title: Headline5(text: mediaItem.title),
                          subtitle: CaptionL(text: mediaItem.artist),
                          leading: CachedNetworkImage(
                            imageUrl: mediaItem.artUri
                                .replaceAll("large", "t300x300"),
                            imageBuilder: (context, imageProvider) => Container(
                              height: 54.00,
                              width: 54.00,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
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
                            placeholder: (context, url) => Container(
                              height: 54.00,
                              width: 54.00,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/placholder.jpg"),
                                    fit: BoxFit.cover),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0.00, 3.00),
                                    color: Color(0xff00a650).withOpacity(0.30),
                                    blurRadius: 26,
                                  ),
                                ],
                                borderRadius: BorderRadius.circular(
                                    15.00), //assets/images/placholder.jpg
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          trailing: IconButton(
                              icon: new Icon(
                                playing ? Icons.pause : Icons.play_arrow,
                                color: Colors.black,
                              ),
                              onPressed: playing
                                  ? AudioService.pause
                                  : AudioService.play)),
                    ],
                  ),
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
        // ignore: unused_local_variable
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
