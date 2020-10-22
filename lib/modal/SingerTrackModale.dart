// To parse this JSON data, do
//
//     final singerTracksModal = singerTracksModalFromJson(jsonString);

// import 'dart:convert';

// SingerTracksModal singerTracksModalFromJson(String str) => SingerTracksModal.fromJson(json.decode(str));

// String singerTracksModalToJson(SingerTracksModal data) => json.encode(data.toJson());

class SingerTracksModal {
    SingerTracksModal({
        this.collection,
        this.nextHref,
        this.queryUrn,
    });

    List<Collection> collection;
    String nextHref;
    dynamic queryUrn;

    factory SingerTracksModal.fromJson(Map<String, dynamic> json) => SingerTracksModal(
        collection: json["collection"] == null ? null : List<Collection>.from(json["collection"].map((x) => Collection.fromJson(x))),
        nextHref: json["next_href"] == null ? null : json["next_href"],
        queryUrn: json["query_urn"],
    );

    Map<String, dynamic> toJson() => {
        "collection": collection == null ? null : List<dynamic>.from(collection.map((x) => x.toJson())),
        "next_href": nextHref == null ? null : nextHref,
        "query_urn": queryUrn,
    };
}

class Collection {
    Collection({
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
    String kind;
    String labelName;
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
    String monetizationModel;
    String policy;
    User user;

    factory Collection.fromJson(Map<String, dynamic> json) => Collection(
        artworkUrl: json["artwork_url"] == null ? null : json["artwork_url"],
        caption: json["caption"],
        commentable: json["commentable"] == null ? null : json["commentable"],
        commentCount: json["comment_count"] == null ? null : json["comment_count"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        description: json["description"] == null ? null : json["description"],
        downloadable: json["downloadable"] == null ? null : json["downloadable"],
        downloadCount: json["download_count"] == null ? null : json["download_count"],
        duration: json["duration"] == null ? null : json["duration"],
        fullDuration: json["full_duration"] == null ? null : json["full_duration"],
        embeddableBy: json["embeddable_by"] == null ? null : json["embeddable_by"],
        genre: json["genre"] == null ? null : json["genre"],
        hasDownloadsLeft: json["has_downloads_left"] == null ? null : json["has_downloads_left"],
        id: json["id"] == null ? null : json["id"],
        kind: json["kind"] == null ? null : json["kind"],
        labelName: json["label_name"] == null ? null : json["label_name"],
        lastModified: json["last_modified"] == null ? null : DateTime.parse(json["last_modified"]),
        license: json["license"] == null ? null : json["license"],
        likesCount: json["likes_count"] == null ? null : json["likes_count"],
        permalink: json["permalink"] == null ? null : json["permalink"],
        permalinkUrl: json["permalink_url"] == null ? null : json["permalink_url"],
        playbackCount: json["playback_count"] == null ? null : json["playback_count"],
        public: json["public"] == null ? null : json["public"],
        publisherMetadata: json["publisher_metadata"] == null ? null : PublisherMetadata.fromJson(json["publisher_metadata"]),
        purchaseTitle: json["purchase_title"] == null ? null : json["purchase_title"],
        purchaseUrl: json["purchase_url"] == null ? null : json["purchase_url"],
        releaseDate: json["release_date"] == null ? null : DateTime.parse(json["release_date"]),
        repostsCount: json["reposts_count"] == null ? null : json["reposts_count"],
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
        displayDate: json["display_date"] == null ? null : DateTime.parse(json["display_date"]),
        media: json["media"] == null ? null : Media.fromJson(json["media"]),
        monetizationModel: json["monetization_model"] == null ? null : json["monetization_model"],
        policy: json["policy"] == null ? null : json["policy"],
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
        "has_downloads_left": hasDownloadsLeft == null ? null : hasDownloadsLeft,
        "id": id == null ? null : id,
        "kind": kind == null ? null : kind,
        "label_name": labelName == null ? null : labelName,
        "last_modified": lastModified == null ? null : lastModified.toIso8601String(),
        "license": license == null ? null : license,
        "likes_count": likesCount == null ? null : likesCount,
        "permalink": permalink == null ? null : permalink,
        "permalink_url": permalinkUrl == null ? null : permalinkUrl,
        "playback_count": playbackCount == null ? null : playbackCount,
        "public": public == null ? null : public,
        "publisher_metadata": publisherMetadata == null ? null : publisherMetadata.toJson(),
        "purchase_title": purchaseTitle == null ? null : purchaseTitle,
        "purchase_url": purchaseUrl == null ? null : purchaseUrl,
        "release_date": releaseDate == null ? null : releaseDate.toIso8601String(),
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
        "display_date": displayDate == null ? null : displayDate.toIso8601String(),
        "media": media == null ? null : media.toJson(),
        "monetization_model": monetizationModel == null ? null : monetizationModel,
        "policy": policy == null ? null : policy,
        "user": user == null ? null : user.toJson(),
    };
}

class Media {
    Media({
        this.transcodings,
    });

    List<Transcoding> transcodings;

    factory Media.fromJson(Map<String, dynamic> json) => Media(
        transcodings: json["transcodings"] == null ? null : List<Transcoding>.from(json["transcodings"].map((x) => Transcoding.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "transcodings": transcodings == null ? null : List<dynamic>.from(transcodings.map((x) => x.toJson())),
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
    String preset;
    int duration;
    bool snipped;
    Format format;
    String quality;

    factory Transcoding.fromJson(Map<String, dynamic> json) => Transcoding(
        url: json["url"] == null ? null : json["url"],
        preset: json["preset"] == null ? null : json["preset"],
        duration: json["duration"] == null ? null : json["duration"],
        snipped: json["snipped"] == null ? null : json["snipped"],
        format: json["format"] == null ? null : Format.fromJson(json["format"]),
        quality: json["quality"] == null ? null : json["quality"],
    );

    Map<String, dynamic> toJson() => {
        "url": url == null ? null : url,
        "preset": preset == null ? null : preset,
        "duration": duration == null ? null : duration,
        "snipped": snipped == null ? null : snipped,
        "format": format == null ? null : format.toJson(),
        "quality": quality == null ? null : quality,
    };
}

class Format {
    Format({
        this.protocol,
        this.mimeType,
    });

    String protocol;
    String mimeType;

    factory Format.fromJson(Map<String, dynamic> json) => Format(
        protocol: json["protocol"] == null ? null : json["protocol"],
        mimeType: json["mime_type"] == null ? null : json["mime_type"],
    );

    Map<String, dynamic> toJson() => {
        "protocol": protocol == null ? null : protocol,
        "mime_type": mimeType == null ? null : mimeType,
    };
}

class PublisherMetadata {
    PublisherMetadata({
        this.id,
        this.urn,
        this.artist,
        this.containsMusic,
        this.isrc,
        this.albumTitle,
    });

    int id;
    String urn;
    String artist;
    bool containsMusic;
    String isrc;
    String albumTitle;

    factory PublisherMetadata.fromJson(Map<String, dynamic> json) => PublisherMetadata(
        id: json["id"] == null ? null : json["id"],
        urn: json["urn"] == null ? null : json["urn"],
        artist: json["artist"] == null ? null : json["artist"],
        containsMusic: json["contains_music"] == null ? null : json["contains_music"],
        isrc: json["isrc"] == null ? null : json["isrc"],
        albumTitle: json["album_title"] == null ? null : json["album_title"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "urn": urn == null ? null : urn,
        "artist": artist == null ? null : artist,
        "contains_music": containsMusic == null ? null : containsMusic,
        "isrc": isrc == null ? null : isrc,
        "album_title": albumTitle == null ? null : albumTitle,
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
    dynamic countryCode;
    Badges badges;

    factory User.fromJson(Map<String, dynamic> json) => User(
        avatarUrl: json["avatar_url"] == null ? null : json["avatar_url"],
        firstName: json["first_name"] == null ? null : json["first_name"],
        fullName: json["full_name"] == null ? null : json["full_name"],
        id: json["id"] == null ? null : json["id"],
        kind: json["kind"] == null ? null : json["kind"],
        lastModified: json["last_modified"] == null ? null : DateTime.parse(json["last_modified"]),
        lastName: json["last_name"] == null ? null : json["last_name"],
        permalink: json["permalink"] == null ? null : json["permalink"],
        permalinkUrl: json["permalink_url"] == null ? null : json["permalink_url"],
        uri: json["uri"] == null ? null : json["uri"],
        urn: json["urn"] == null ? null : json["urn"],
        username: json["username"] == null ? null : json["username"],
        verified: json["verified"] == null ? null : json["verified"],
        city: json["city"] == null ? null : json["city"],
        countryCode: json["country_code"],
        badges: json["badges"] == null ? null : Badges.fromJson(json["badges"]),
    );

    Map<String, dynamic> toJson() => {
        "avatar_url": avatarUrl == null ? null : avatarUrl,
        "first_name": firstName == null ? null : firstName,
        "full_name": fullName == null ? null : fullName,
        "id": id == null ? null : id,
        "kind": kind == null ? null : kind,
        "last_modified": lastModified == null ? null : lastModified.toIso8601String(),
        "last_name": lastName == null ? null : lastName,
        "permalink": permalink == null ? null : permalink,
        "permalink_url": permalinkUrl == null ? null : permalinkUrl,
        "uri": uri == null ? null : uri,
        "urn": urn == null ? null : urn,
        "username": username == null ? null : username,
        "verified": verified == null ? null : verified,
        "city": city == null ? null : city,
        "country_code": countryCode,
        "badges": badges == null ? null : badges.toJson(),
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
        proUnlimited: json["pro_unlimited"] == null ? null : json["pro_unlimited"],
        verified: json["verified"] == null ? null : json["verified"],
    );

    Map<String, dynamic> toJson() => {
        "pro_unlimited": proUnlimited == null ? null : proUnlimited,
        "verified": verified == null ? null : verified,
    };
}
