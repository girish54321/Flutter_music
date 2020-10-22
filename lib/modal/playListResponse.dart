class PlayListResponse {
  PlayListResponse({
    this.artworkUrl,
    this.createdAt,
    this.description,
    this.duration,
    this.embeddableBy,
    this.genre,
    this.id,
    this.kind,
    this.labelName,
    this.lastModified,
    this.license,
    this.likesCount,
    this.managedByFeeds,
    this.permalink,
    this.permalinkUrl,
    this.public,
    this.purchaseTitle,
    this.purchaseUrl,
    this.releaseDate,
    this.repostsCount,
    this.secretToken,
    this.sharing,
    this.tagList,
    this.title,
    this.uri,
    this.userId,
    this.setType,
    this.isAlbum,
    this.publishedAt,
    this.displayDate,
    this.user,
    this.tracks,
    this.trackCount,
  });

  String artworkUrl;
  DateTime createdAt;
  dynamic description;
  int duration;
  String embeddableBy;
  String genre;
  int id;
  String kind;
  dynamic labelName;
  DateTime lastModified;
  String license;
  int likesCount;
  bool managedByFeeds;
  String permalink;
  String permalinkUrl;
  bool public;
  dynamic purchaseTitle;
  dynamic purchaseUrl;
  dynamic releaseDate;
  int repostsCount;
  dynamic secretToken;
  String sharing;
  String tagList;
  String title;
  String uri;
  int userId;
  String setType;
  bool isAlbum;
  DateTime publishedAt;
  DateTime displayDate;
  User user;
  List<Track> tracks;
  int trackCount;

  factory PlayListResponse.fromJson(Map<String, dynamic> json) =>
      PlayListResponse(
        artworkUrl: json["artwork_url"],
        createdAt: DateTime.parse(json["created_at"]),
        description: json["description"],
        duration: json["duration"],
        embeddableBy: json["embeddable_by"],
        genre: json["genre"],
        id: json["id"],
        kind: json["kind"],
        labelName: json["label_name"],
        lastModified: DateTime.parse(json["last_modified"]),
        license: json["license"],
        likesCount: json["likes_count"],
        managedByFeeds: json["managed_by_feeds"],
        permalink: json["permalink"],
        permalinkUrl: json["permalink_url"],
        public: json["public"],
        purchaseTitle: json["purchase_title"],
        purchaseUrl: json["purchase_url"],
        releaseDate: json["release_date"],
        repostsCount: json["reposts_count"],
        secretToken: json["secret_token"],
        sharing: json["sharing"],
        tagList: json["tag_list"],
        title: json["title"],
        uri: json["uri"],
        userId: json["user_id"],
        setType: json["set_type"],
        isAlbum: json["is_album"],
        publishedAt: DateTime.parse(json["published_at"]),
        displayDate: DateTime.parse(json["display_date"]),
        user: User.fromJson(json["user"]),
        tracks: List<Track>.from(json["tracks"].map((x) => Track.fromJson(x))),
        trackCount: json["track_count"],
      );

  Map<String, dynamic> toJson() => {
        "artwork_url": artworkUrl,
        "created_at": createdAt.toIso8601String(),
        "description": description,
        "duration": duration,
        "embeddable_by": embeddableBy,
        "genre": genre,
        "id": id,
        "kind": kind,
        "label_name": labelName,
        "last_modified": lastModified.toIso8601String(),
        "license": license,
        "likes_count": likesCount,
        "managed_by_feeds": managedByFeeds,
        "permalink": permalink,
        "permalink_url": permalinkUrl,
        "public": public,
        "purchase_title": purchaseTitle,
        "purchase_url": purchaseUrl,
        "release_date": releaseDate,
        "reposts_count": repostsCount,
        "secret_token": secretToken,
        "sharing": sharing,
        "tag_list": tagList,
        "title": title,
        "uri": uri,
        "user_id": userId,
        "set_type": setType,
        "is_album": isAlbum,
        "published_at": publishedAt.toIso8601String(),
        "display_date": displayDate.toIso8601String(),
        "user": user.toJson(),
        "tracks": List<dynamic>.from(tracks.map((x) => x.toJson())),
        "track_count": trackCount,
      };
}

class Track {
  Track({
    this.artworkUrl,
    this.caption,
    this.commentable,
    this.commentCount,
    this.createdAt,
    this.description,
    this.downloadable,
    this.downloadCount,
    this.duration,
    this.fullDuration,
    this.embeddableBy,
    this.genre,
    this.hasDownloadsLeft,
    this.id,
    this.kind,
    this.labelName,
    this.lastModified,
    this.license,
    this.likesCount,
    this.permalink,
    this.permalinkUrl,
    this.playbackCount,
    this.public,
    this.publisherMetadata,
    this.purchaseTitle,
    this.purchaseUrl,
    this.releaseDate,
    this.repostsCount,
    this.secretToken,
    this.sharing,
    this.state,
    this.streamable,
    this.tagList,
    this.title,
    this.uri,
    this.urn,
    this.userId,
    this.visuals,
    this.waveformUrl,
    this.displayDate,
    this.media,
    this.monetizationModel,
    this.policy,
    this.user,
  });

  String artworkUrl;
  dynamic caption;
  bool commentable;
  int commentCount;
  DateTime createdAt;
  String description;
  bool downloadable;
  int downloadCount;
  int duration;
  int fullDuration;
  String embeddableBy;
  String genre;
  bool hasDownloadsLeft;
  int id;
  Kind kind;
  dynamic labelName;
  DateTime lastModified;
  String license;
  int likesCount;
  String permalink;
  String permalinkUrl;
  int playbackCount;
  bool public;
  PublisherMetadata publisherMetadata;
  String purchaseTitle;
  String purchaseUrl;
  dynamic releaseDate;
  int repostsCount;
  dynamic secretToken;
  String sharing;
  String state;
  bool streamable;
  String tagList;
  String title;
  String uri;
  String urn;
  int userId;
  dynamic visuals;
  String waveformUrl;
  DateTime displayDate;
  Media media;
  MonetizationModel monetizationModel;
  Policy policy;
  User user;

  factory Track.fromJson(Map<String, dynamic> json) => Track(
        artworkUrl: json["artwork_url"] == null ? null : json["artwork_url"],
        caption: json["caption"],
        commentable: json["commentable"] == null ? null : json["commentable"],
        commentCount:
            json["comment_count"] == null ? null : json["comment_count"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        description: json["description"] == null ? null : json["description"],
        downloadable:
            json["downloadable"] == null ? null : json["downloadable"],
        downloadCount:
            json["download_count"] == null ? null : json["download_count"],
        duration: json["duration"] == null ? null : json["duration"],
        fullDuration:
            json["full_duration"] == null ? null : json["full_duration"],
        embeddableBy:
            json["embeddable_by"] == null ? null : json["embeddable_by"],
        genre: json["genre"] == null ? null : json["genre"],
        hasDownloadsLeft: json["has_downloads_left"] == null
            ? null
            : json["has_downloads_left"],
        id: json["id"],
        kind: kindValues.map[json["kind"]],
        labelName: json["label_name"],
        lastModified: json["last_modified"] == null
            ? null
            : DateTime.parse(json["last_modified"]),
        license: json["license"] == null ? null : json["license"],
        likesCount: json["likes_count"] == null ? null : json["likes_count"],
        permalink: json["permalink"] == null ? null : json["permalink"],
        permalinkUrl:
            json["permalink_url"] == null ? null : json["permalink_url"],
        playbackCount:
            json["playback_count"] == null ? null : json["playback_count"],
        public: json["public"] == null ? null : json["public"],
        publisherMetadata: json["publisher_metadata"] == null
            ? null
            : PublisherMetadata.fromJson(json["publisher_metadata"]),
        purchaseTitle:
            json["purchase_title"] == null ? null : json["purchase_title"],
        purchaseUrl: json["purchase_url"] == null ? null : json["purchase_url"],
        releaseDate: json["release_date"],
        repostsCount:
            json["reposts_count"] == null ? null : json["reposts_count"],
        secretToken: json["secret_token"],
        sharing: json["sharing"] == null ? null : json["sharing"],
        state: json["state"] == null ? null : json["state"],
        streamable: json["streamable"] == null ? null : json["streamable"],
        tagList: json["tag_list"] == null ? null : json["tag_list"],
        title: json["title"] == null ? null : json["title"],
        uri: json["uri"] == null ? null : json["uri"],
        urn: json["urn"] == null ? null : json["urn"],
        userId: json["user_id"] == null ? null : json["user_id"],
        visuals: json["visuals"],
        waveformUrl: json["waveform_url"] == null ? null : json["waveform_url"],
        displayDate: json["display_date"] == null
            ? null
            : DateTime.parse(json["display_date"]),
        media: json["media"] == null ? null : Media.fromJson(json["media"]),
        monetizationModel:
            monetizationModelValues.map[json["monetization_model"]],
        policy: policyValues.map[json["policy"]],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "artwork_url": artworkUrl == null ? null : artworkUrl,
        "caption": caption,
        "commentable": commentable == null ? null : commentable,
        "comment_count": commentCount == null ? null : commentCount,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "description": description == null ? null : description,
        "downloadable": downloadable == null ? null : downloadable,
        "download_count": downloadCount == null ? null : downloadCount,
        "duration": duration == null ? null : duration,
        "full_duration": fullDuration == null ? null : fullDuration,
        "embeddable_by": embeddableBy == null ? null : embeddableBy,
        "genre": genre == null ? null : genre,
        "has_downloads_left":
            hasDownloadsLeft == null ? null : hasDownloadsLeft,
        "id": id,
        "kind": kindValues.reverse[kind],
        "label_name": labelName,
        "last_modified":
            lastModified == null ? null : lastModified.toIso8601String(),
        "license": license == null ? null : license,
        "likes_count": likesCount == null ? null : likesCount,
        "permalink": permalink == null ? null : permalink,
        "permalink_url": permalinkUrl == null ? null : permalinkUrl,
        "playback_count": playbackCount == null ? null : playbackCount,
        "public": public == null ? null : public,
        "publisher_metadata":
            publisherMetadata == null ? null : publisherMetadata.toJson(),
        "purchase_title": purchaseTitle == null ? null : purchaseTitle,
        "purchase_url": purchaseUrl == null ? null : purchaseUrl,
        "release_date": releaseDate,
        "reposts_count": repostsCount == null ? null : repostsCount,
        "secret_token": secretToken,
        "sharing": sharing == null ? null : sharing,
        "state": state == null ? null : state,
        "streamable": streamable == null ? null : streamable,
        "tag_list": tagList == null ? null : tagList,
        "title": title == null ? null : title,
        "uri": uri == null ? null : uri,
        "urn": urn == null ? null : urn,
        "user_id": userId == null ? null : userId,
        "visuals": visuals,
        "waveform_url": waveformUrl == null ? null : waveformUrl,
        "display_date":
            displayDate == null ? null : displayDate.toIso8601String(),
        "media": media == null ? null : media.toJson(),
        "monetization_model":
            monetizationModelValues.reverse[monetizationModel],
        "policy": policyValues.reverse[policy],
        "user": user == null ? null : user.toJson(),
      };
}

enum Kind { TRACK }

final kindValues = EnumValues({"track": Kind.TRACK});

class Media {
  Media({
    this.transcodings,
  });

  List<Transcoding> transcodings;

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        transcodings: List<Transcoding>.from(
            json["transcodings"].map((x) => Transcoding.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "transcodings": List<dynamic>.from(transcodings.map((x) => x.toJson())),
      };
}

class Transcoding {
  Transcoding({
    this.url,
    this.preset,
    this.duration,
    this.snipped,
    this.format,
    this.quality,
  });

  String url;
  Preset preset;
  int duration;
  bool snipped;
  Format format;
  Quality quality;

  factory Transcoding.fromJson(Map<String, dynamic> json) => Transcoding(
        url: json["url"],
        preset: presetValues.map[json["preset"]],
        duration: json["duration"],
        snipped: json["snipped"],
        format: Format.fromJson(json["format"]),
        quality: qualityValues.map[json["quality"]],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "preset": presetValues.reverse[preset],
        "duration": duration,
        "snipped": snipped,
        "format": format.toJson(),
        "quality": qualityValues.reverse[quality],
      };
}

class Format {
  Format({
    this.protocol,
    this.mimeType,
  });

  Protocol protocol;
  MimeType mimeType;

  factory Format.fromJson(Map<String, dynamic> json) => Format(
        protocol: protocolValues.map[json["protocol"]],
        mimeType: mimeTypeValues.map[json["mime_type"]],
      );

  Map<String, dynamic> toJson() => {
        "protocol": protocolValues.reverse[protocol],
        "mime_type": mimeTypeValues.reverse[mimeType],
      };
}

enum MimeType { AUDIO_MPEG, AUDIO_OGG_CODECS_OPUS }

final mimeTypeValues = EnumValues({
  "audio/mpeg": MimeType.AUDIO_MPEG,
  "audio/ogg; codecs=\"opus\"": MimeType.AUDIO_OGG_CODECS_OPUS
});

enum Protocol { HLS, PROGRESSIVE }

final protocolValues =
    EnumValues({"hls": Protocol.HLS, "progressive": Protocol.PROGRESSIVE});

enum Preset { MP3_00, OPUS_00 }

final presetValues =
    EnumValues({"mp3_0_0": Preset.MP3_00, "opus_0_0": Preset.OPUS_00});

enum Quality { SQ }

final qualityValues = EnumValues({"sq": Quality.SQ});

enum MonetizationModel { NOT_APPLICABLE }

final monetizationModelValues =
    EnumValues({"NOT_APPLICABLE": MonetizationModel.NOT_APPLICABLE});

enum Policy { ALLOW }

final policyValues = EnumValues({"ALLOW": Policy.ALLOW});

class PublisherMetadata {
  PublisherMetadata({
    this.id,
    this.urn,
    this.artist,
    this.containsMusic,
    this.isrc,
    this.publisher,
    this.writerComposer,
  });

  int id;
  String urn;
  String artist;
  bool containsMusic;
  String isrc;
  String publisher;
  String writerComposer;

  factory PublisherMetadata.fromJson(Map<String, dynamic> json) =>
      PublisherMetadata(
        id: json["id"],
        urn: json["urn"],
        artist: json["artist"],
        containsMusic: json["contains_music"],
        isrc: json["isrc"],
        publisher: json["publisher"] == null ? null : json["publisher"],
        writerComposer:
            json["writer_composer"] == null ? null : json["writer_composer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "urn": urn,
        "artist": artist,
        "contains_music": containsMusic,
        "isrc": isrc,
        "publisher": publisher == null ? null : publisher,
        "writer_composer": writerComposer == null ? null : writerComposer,
      };
}

class User {
  User({
    this.avatarUrl,
    this.firstName,
    this.fullName,
    this.id,
    this.kind,
    this.lastModified,
    this.lastName,
    this.permalink,
    this.permalinkUrl,
    this.uri,
    this.urn,
    this.username,
    this.verified,
    this.city,
    this.countryCode,
    this.badges,
  });

  String avatarUrl;
  String firstName;
  String fullName;
  int id;
  String kind;
  DateTime lastModified;
  String lastName;
  String permalink;
  String permalinkUrl;
  String uri;
  String urn;
  String username;
  bool verified;
  String city;
  String countryCode;
  Badges badges;

  factory User.fromJson(Map<String, dynamic> json) => User(
        avatarUrl: json["avatar_url"],
        firstName: json["first_name"],
        fullName: json["full_name"],
        id: json["id"],
        kind: json["kind"],
        lastModified: DateTime.parse(json["last_modified"]),
        lastName: json["last_name"],
        permalink: json["permalink"],
        permalinkUrl: json["permalink_url"],
        uri: json["uri"],
        urn: json["urn"],
        username: json["username"],
        verified: json["verified"],
        city: json["city"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
        badges: Badges.fromJson(json["badges"]),
      );

  Map<String, dynamic> toJson() => {
        "avatar_url": avatarUrl,
        "first_name": firstName,
        "full_name": fullName,
        "id": id,
        "kind": kind,
        "last_modified": lastModified.toIso8601String(),
        "last_name": lastName,
        "permalink": permalink,
        "permalink_url": permalinkUrl,
        "uri": uri,
        "urn": urn,
        "username": username,
        "verified": verified,
        "city": city,
        "country_code": countryCode == null ? null : countryCode,
        "badges": badges.toJson(),
      };
}

class Badges {
  Badges({
    this.proUnlimited,
    this.verified,
  });

  bool proUnlimited;
  bool verified;

  factory Badges.fromJson(Map<String, dynamic> json) => Badges(
        proUnlimited: json["pro_unlimited"],
        verified: json["verified"],
      );

  Map<String, dynamic> toJson() => {
        "pro_unlimited": proUnlimited,
        "verified": verified,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
