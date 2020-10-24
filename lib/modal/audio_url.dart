class AudioUrl {
  AudioUrl({
    this.url,
  });

  String url;

  factory AudioUrl.fromJson(Map<String, dynamic> json) => AudioUrl(
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
      };
}
