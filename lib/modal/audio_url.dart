// To parse this JSON data, do
//
//     final audioUrl = audioUrlFromJson(jsonString);

// import 'dart:convert';

// AudioUrl audioUrlFromJson(String str) => AudioUrl.fromJson(json.decode(str));

// String audioUrlToJson(AudioUrl data) => json.encode(data.toJson());

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
