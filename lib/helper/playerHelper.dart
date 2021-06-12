import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:musicPlayer/DatabaseOperations/DatabaseOperations.dart';
import 'package:musicPlayer/helper/helper.dart';
import 'package:musicPlayer/modal/player_song_list.dart';
import 'package:musicPlayer/provider/RecentlyPlayedProvider.dart';
import 'package:musicPlayer/screen/MusicPlayer/MusicPlayerScreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class PlayerHelper {
  playSong(List<NowPlayingClass> nowPlaying, BuildContext context,
      Function clearList) async {
    final recentlyPlayedProvider = context.read<RecentlyPlayedProvider>();
    if (AudioService.running) {
      if (nowPlaying != null) {
        var listItem = nowPlaying[0];
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

        Future.delayed(Duration(seconds: 1));
        await AudioService.addQueueItem(mediaItem);
        DatabaseOperations().insertRecentlyPlayed(nowPlaying[0]);
        recentlyPlayedProvider.updateList();
        await Helper().showLoadingDilog(context).hide();
        Helper().showSnackBar("Added To PlayList.", "Done.", context, false);
        await Future.delayed(Duration(seconds: 1));
        clearList();
      }
    } else {
      if (nowPlaying != null) {
        await Helper().showLoadingDilog(context).hide();
        DatabaseOperations().insertRecentlyPlayed(nowPlaying[0]);
        recentlyPlayedProvider.updateList();
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.rightToLeft,
                child: BGAudioPlayerScreen(
                  nowPlayingClass: nowPlaying,
                )));
        await Future.delayed(Duration(seconds: 1));
        clearList();
      }
    }
  }
}
