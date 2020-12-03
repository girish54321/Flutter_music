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
  String description;
  int duration;
  String embeddableBy;
  String genre;
  int id;
  String kind;
  String labelName;
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
  dynamic publishedAt;
  DateTime displayDate;
  User user;
  List<Track> tracks;
  int trackCount;

  factory PlayListResponse.fromJson(Map<String, dynamic> json) =>
      PlayListResponse(
        artworkUrl: json["artwork_url"] == null ? null : json["artwork_url"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        description: json["description"] == null ? null : json["description"],
        duration: json["duration"] == null ? null : json["duration"],
        embeddableBy:
            json["embeddable_by"] == null ? null : json["embeddable_by"],
        genre: json["genre"] == null ? null : json["genre"],
        id: json["id"] == null ? null : json["id"],
        kind: json["kind"] == null ? null : json["kind"],
        labelName: json["label_name"] == null ? null : json["label_name"],
        lastModified: json["last_modified"] == null
            ? null
            : DateTime.parse(json["last_modified"]),
        license: json["license"] == null ? null : json["license"],
        likesCount: json["likes_count"] == null ? null : json["likes_count"],
        managedByFeeds:
            json["managed_by_feeds"] == null ? null : json["managed_by_feeds"],
        permalink: json["permalink"] == null ? null : json["permalink"],
        permalinkUrl:
            json["permalink_url"] == null ? null : json["permalink_url"],
        public: json["public"] == null ? null : json["public"],
        purchaseTitle: json["purchase_title"],
        purchaseUrl: json["purchase_url"],
        releaseDate: json["release_date"],
        repostsCount:
            json["reposts_count"] == null ? null : json["reposts_count"],
        secretToken: json["secret_token"],
        sharing: json["sharing"] == null ? null : json["sharing"],
        tagList: json["tag_list"] == null ? null : json["tag_list"],
        title: json["title"] == null ? null : json["title"],
        uri: json["uri"] == null ? null : json["uri"],
        userId: json["user_id"] == null ? null : json["user_id"],
        setType: json["set_type"] == null ? null : json["set_type"],
        isAlbum: json["is_album"] == null ? null : json["is_album"],
        publishedAt: json["published_at"],
        displayDate: json["display_date"] == null
            ? null
            : DateTime.parse(json["display_date"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        tracks: json["tracks"] == null
            ? null
            : List<Track>.from(json["tracks"].map((x) => Track.fromJson(x))),
        trackCount: json["track_count"] == null ? null : json["track_count"],
      );

  Map<String, dynamic> toJson() => {
        "artwork_url": artworkUrl == null ? null : artworkUrl,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "description": description == null ? null : description,
        "duration": duration == null ? null : duration,
        "embeddable_by": embeddableBy == null ? null : embeddableBy,
        "genre": genre == null ? null : genre,
        "id": id == null ? null : id,
        "kind": kind == null ? null : kind,
        "label_name": labelName == null ? null : labelName,
        "last_modified":
            lastModified == null ? null : lastModified.toIso8601String(),
        "license": license == null ? null : license,
        "likes_count": likesCount == null ? null : likesCount,
        "managed_by_feeds": managedByFeeds == null ? null : managedByFeeds,
        "permalink": permalink == null ? null : permalink,
        "permalink_url": permalinkUrl == null ? null : permalinkUrl,
        "public": public == null ? null : public,
        "purchase_title": purchaseTitle,
        "purchase_url": purchaseUrl,
        "release_date": releaseDate,
        "reposts_count": repostsCount == null ? null : repostsCount,
        "secret_token": secretToken,
        "sharing": sharing == null ? null : sharing,
        "tag_list": tagList == null ? null : tagList,
        "title": title == null ? null : title,
        "uri": uri == null ? null : uri,
        "user_id": userId == null ? null : userId,
        "set_type": setType == null ? null : setType,
        "is_album": isAlbum == null ? null : isAlbum,
        "published_at": publishedAt,
        "display_date":
            displayDate == null ? null : displayDate.toIso8601String(),
        "user": user == null ? null : user.toJson(),
        "tracks": tracks == null
            ? null
            : List<dynamic>.from(tracks.map((x) => x.toJson())),
        "track_count": trackCount == null ? null : trackCount,
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
  String labelName;
  DateTime lastModified;
  String license;
  int likesCount;
  String permalink;
  String permalinkUrl;
  int playbackCount;
  bool public;
  PublisherMetadata publisherMetadata;
  dynamic purchaseTitle;
  String purchaseUrl;
  DateTime releaseDate;
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
        id: json["id"] == null ? null : json["id"],
        kind: json["kind"] == null ? null : kindValues.map[json["kind"]],
        labelName: json["label_name"] == null ? null : json["label_name"],
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
        purchaseTitle: json["purchase_title"],
        purchaseUrl: json["purchase_url"] == null ? null : json["purchase_url"],
        releaseDate: json["release_date"] == null
            ? null
            : DateTime.parse(json["release_date"]),
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
        monetizationModel: json["monetization_model"] == null
            ? null
            : monetizationModelValues.map[json["monetization_model"]],
        policy:
            json["policy"] == null ? null : policyValues.map[json["policy"]],
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
        "id": id == null ? null : id,
        "kind": kind == null ? null : kindValues.reverse[kind],
        "label_name": labelName == null ? null : labelName,
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
        "purchase_title": purchaseTitle,
        "purchase_url": purchaseUrl == null ? null : purchaseUrl,
        "release_date":
            releaseDate == null ? null : releaseDate.toIso8601String(),
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
        "monetization_model": monetizationModel == null
            ? null
            : monetizationModelValues.reverse[monetizationModel],
        "policy": policy == null ? null : policyValues.reverse[policy],
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
        transcodings: json["transcodings"] == null
            ? null
            : List<Transcoding>.from(
                json["transcodings"].map((x) => Transcoding.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "transcodings": transcodings == null
            ? null
            : List<dynamic>.from(transcodings.map((x) => x.toJson())),
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
        url: json["url"] == null ? null : json["url"],
        preset:
            json["preset"] == null ? null : presetValues.map[json["preset"]],
        duration: json["duration"] == null ? null : json["duration"],
        snipped: json["snipped"] == null ? null : json["snipped"],
        format: json["format"] == null ? null : Format.fromJson(json["format"]),
        quality:
            json["quality"] == null ? null : qualityValues.map[json["quality"]],
      );

  Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "preset": preset == null ? null : presetValues.reverse[preset],
        "duration": duration == null ? null : duration,
        "snipped": snipped == null ? null : snipped,
        "format": format == null ? null : format.toJson(),
        "quality": quality == null ? null : qualityValues.reverse[quality],
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
        protocol: json["protocol"] == null
            ? null
            : protocolValues.map[json["protocol"]],
        mimeType: json["mime_type"] == null
            ? null
            : mimeTypeValues.map[json["mime_type"]],
      );

  Map<String, dynamic> toJson() => {
        "protocol": protocol == null ? null : protocolValues.reverse[protocol],
        "mime_type": mimeType == null ? null : mimeTypeValues.reverse[mimeType],
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

enum Preset { MP3_00, OPUS_00, MP3_01 }

final presetValues = EnumValues({
  "mp3_0_0": Preset.MP3_00,
  "mp3_0_1": Preset.MP3_01,
  "opus_0_0": Preset.OPUS_00
});

enum Quality { SQ }

final qualityValues = EnumValues({"sq": Quality.SQ});

enum MonetizationModel { NOT_APPLICABLE }

final monetizationModelValues =
    EnumValues({"NOT_APPLICABLE": MonetizationModel.NOT_APPLICABLE});

enum Policy { ALLOW, BLOCK, SNIP }

final policyValues = EnumValues(
    {"ALLOW": Policy.ALLOW, "BLOCK": Policy.BLOCK, "SNIP": Policy.SNIP});

class PublisherMetadata {
  PublisherMetadata({
    this.id,
    this.urn,
    this.artist,
    this.containsMusic,
    this.publisher,
    this.isrc,
    this.writerComposer,
    this.albumTitle,
    this.iswc,
    this.upcOrEan,
    this.pLine,
    this.pLineForDisplay,
    this.releaseTitle,
  });

  int id;
  String urn;
  String artist;
  bool containsMusic;
  String publisher;
  String isrc;
  String writerComposer;
  String albumTitle;
  String iswc;
  String upcOrEan;
  String pLine;
  String pLineForDisplay;
  String releaseTitle;

  factory PublisherMetadata.fromJson(Map<String, dynamic> json) =>
      PublisherMetadata(
        id: json["id"] == null ? null : json["id"],
        urn: json["urn"] == null ? null : json["urn"],
        artist: json["artist"] == null ? null : json["artist"],
        containsMusic:
            json["contains_music"] == null ? null : json["contains_music"],
        publisher: json["publisher"] == null ? null : json["publisher"],
        isrc: json["isrc"] == null ? null : json["isrc"],
        writerComposer:
            json["writer_composer"] == null ? null : json["writer_composer"],
        albumTitle: json["album_title"] == null ? null : json["album_title"],
        iswc: json["iswc"] == null ? null : json["iswc"],
        upcOrEan: json["upc_or_ean"] == null ? null : json["upc_or_ean"],
        pLine: json["p_line"] == null ? null : json["p_line"],
        pLineForDisplay: json["p_line_for_display"] == null
            ? null
            : json["p_line_for_display"],
        releaseTitle:
            json["release_title"] == null ? null : json["release_title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "urn": urn == null ? null : urn,
        "artist": artist == null ? null : artist,
        "contains_music": containsMusic == null ? null : containsMusic,
        "publisher": publisher == null ? null : publisher,
        "isrc": isrc == null ? null : isrc,
        "writer_composer": writerComposer == null ? null : writerComposer,
        "album_title": albumTitle == null ? null : albumTitle,
        "iswc": iswc == null ? null : iswc,
        "upc_or_ean": upcOrEan == null ? null : upcOrEan,
        "p_line": pLine == null ? null : pLine,
        "p_line_for_display": pLineForDisplay == null ? null : pLineForDisplay,
        "release_title": releaseTitle == null ? null : releaseTitle,
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
        avatarUrl: json["avatar_url"] == null ? null : json["avatar_url"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        id: json["id"] == null ? null : json["id"],
        kind: json["kind"] == null ? null : json["kind"],
        lastModified: json["last_modified"] == null
            ? null
            : DateTime.parse(json["last_modified"]),
        lastName: json["last_name"] == null ? null : json["last_name"],
        permalink: json["permalink"] == null ? null : json["permalink"],
        permalinkUrl:
            json["permalink_url"] == null ? null : json["permalink_url"],
        uri: json["uri"] == null ? null : json["uri"],
        urn: json["urn"] == null ? null : json["urn"],
        username: json["username"] == null ? null : json["username"],
        verified: json["verified"] == null ? null : json["verified"],
        city: json["city"] == null ? null : json["city"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
        badges: json["badges"] == null ? null : Badges.fromJson(json["badges"]),
      );

  Map<String, dynamic> toJson() => {
        "avatar_url": avatarUrl == null ? null : avatarUrl,
        "first_name": firstName == null ? null : firstName,
        "full_name": fullName == null ? null : fullName,
        "id": id == null ? null : id,
        "kind": kind == null ? null : kind,
        "last_modified":
            lastModified == null ? null : lastModified.toIso8601String(),
        "last_name": lastName == null ? null : lastName,
        "permalink": permalink == null ? null : permalink,
        "permalink_url": permalinkUrl == null ? null : permalinkUrl,
        "uri": uri == null ? null : uri,
        "urn": urn == null ? null : urn,
        "username": username == null ? null : username,
        "verified": verified == null ? null : verified,
        "city": city == null ? null : city,
        "country_code": countryCode == null ? null : countryCode,
        "badges": badges == null ? null : badges.toJson(),
      };
}

class Badges {
  Badges({
    this.pro,
    this.proUnlimited,
    this.verified,
  });

  bool pro;
  bool proUnlimited;
  bool verified;

  factory Badges.fromJson(Map<String, dynamic> json) => Badges(
        pro: json["pro"] == null ? null : json["pro"],
        proUnlimited:
            json["pro_unlimited"] == null ? null : json["pro_unlimited"],
        verified: json["verified"] == null ? null : json["verified"],
      );

  Map<String, dynamic> toJson() => {
        "pro": pro == null ? null : pro,
        "pro_unlimited": proUnlimited == null ? null : proUnlimited,
        "verified": verified == null ? null : verified,
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
