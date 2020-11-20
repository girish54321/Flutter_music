class NowPlayingClass {
  final String url, title, artist, artUri, album;
  final Duration duration;
  final String name;
  final int songId;
  final int singerId;
  final String imageUrl;
  final int fav;
  // ignore: non_constant_identifier_names
  final String audio_url;

  NowPlayingClass(
      this.url,
      this.title,
      this.artist,
      this.artUri,
      this.album,
      this.duration,
      this.name,
      this.songId,
      this.singerId,
      this.imageUrl,
      this.fav,
      this.audio_url);
}
