// To parse this JSON data, do
//
//     final homeSongList = homeSongListFromJson(jsonString);

// import 'dart:convert';

// HomeSongList homeSongListFromJson(String str) => HomeSongList.fromJson(json.decode(str));

// String homeSongListToJson(HomeSongList data) => json.encode(data.toJson());

class HomeSongList {
    HomeSongList({
        this.collection,
        this.nextHref,
        this.queryUrn,
    });

    List<HomeSongListCollection> collection;
    dynamic nextHref;
    String queryUrn;

    factory HomeSongList.fromJson(Map<String, dynamic> json) => HomeSongList(
        collection: List<HomeSongListCollection>.from(json["collection"].map((x) => HomeSongListCollection.fromJson(x))),
        nextHref: json["next_href"],
        queryUrn: json["query_urn"],
    );

    Map<String, dynamic> toJson() => {
        "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
        "next_href": nextHref,
        "query_urn": queryUrn,
    };
}

class HomeSongListCollection {
    HomeSongListCollection({
        this.urn,
        this.queryUrn,
        this.title,
        this.description,
        this.trackingFeatureName,
        this.lastUpdated,
        this.style,
        this.socialProof,
        this.socialProofUsers,
        this.items,
        this.kind,
        this.id,
    });

    String urn;
    String queryUrn;
    String title;
    String description;
    String trackingFeatureName;
    DateTime lastUpdated;
    dynamic style;
    dynamic socialProof;
    dynamic socialProofUsers;
    Items items;
    String kind;
    String id;

    factory HomeSongListCollection.fromJson(Map<String, dynamic> json) => HomeSongListCollection(
        urn: json["urn"],
        queryUrn: json["query_urn"] == null ? null : json["query_urn"],
        title: json["title"],
        description: json["description"],
        trackingFeatureName: json["tracking_feature_name"],
        lastUpdated: json["last_updated"] == null ? null : DateTime.parse(json["last_updated"]),
        style: json["style"],
        socialProof: json["social_proof"],
        socialProofUsers: json["social_proof_users"],
        items: Items.fromJson(json["items"]),
        kind: json["kind"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "urn": urn,
        "query_urn": queryUrn == null ? null : queryUrn,
        "title": title,
        "description": description,
        "tracking_feature_name": trackingFeatureName,
        "last_updated": lastUpdated == null ? null : lastUpdated.toIso8601String(),
        "style": style,
        "social_proof": socialProof,
        "social_proof_users": socialProofUsers,
        "items": items.toJson(),
        "kind": kind,
        "id": id,
    };
}

class Items {
    Items({
        this.collection,
        this.nextHref,
        this.queryUrn,
    });

    List<ItemsCollection> collection;
    dynamic nextHref;
    dynamic queryUrn;

    factory Items.fromJson(Map<String, dynamic> json) => Items(
        collection: List<ItemsCollection>.from(json["collection"].map((x) => ItemsCollection.fromJson(x))),
        nextHref: json["next_href"],
        queryUrn: json["query_urn"],
    );

    Map<String, dynamic> toJson() => {
        "collection": List<dynamic>.from(collection.map((x) => x.toJson())),
        "next_href": nextHref,
        "query_urn": queryUrn,
    };
}

class ItemsCollection {
    ItemsCollection({
        this.artworkUrl,
        this.createdAt,
        this.duration,
        this.id,
        this.kind,
        this.lastModified,
        this.likesCount,
        this.managedByFeeds,
        this.permalink,
        this.permalinkUrl,
        this.public,
        this.repostsCount,
        this.secretToken,
        this.sharing,
        this.title,
        this.trackCount,
        this.uri,
        this.userId,
        this.setType,
        this.isAlbum,
        this.publishedAt,
        this.displayDate,
        this.user,
        this.urn,
        this.queryUrn,
        this.description,
        this.shortTitle,
        this.shortDescription,
        this.trackingFeatureName,
        this.lastUpdated,
        this.calculatedArtworkUrl,
        this.tracks,
        this.isPublic,
        this.madeFor,
    });

    String artworkUrl;
    DateTime createdAt;
    int duration;
    dynamic id;
    CollectionKind kind;
    DateTime lastModified;
    int likesCount;
    bool managedByFeeds;
    String permalink;
    String permalinkUrl;
    bool public;
    int repostsCount;
    dynamic secretToken;
    Sharing sharing;
    String title;
    int trackCount;
    String uri;
    int userId;
    SetType setType;
    bool isAlbum;
    DateTime publishedAt;
    DateTime displayDate;
    User user;
    String urn;
    dynamic queryUrn;
    String description;
    String shortTitle;
    ShortDescription shortDescription;
    TrackingFeatureName trackingFeatureName;
    DateTime lastUpdated;
    String calculatedArtworkUrl;
    List<Track> tracks;
    bool isPublic;
    dynamic madeFor;

    factory ItemsCollection.fromJson(Map<String, dynamic> json) => ItemsCollection(
        artworkUrl: json["artwork_url"] == null ? null : json["artwork_url"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        duration: json["duration"] == null ? null : json["duration"],
        id: json["id"],
        kind: collectionKindValues.map[json["kind"]],
        lastModified: json["last_modified"] == null ? null : DateTime.parse(json["last_modified"]),
        likesCount: json["likes_count"] == null ? null : json["likes_count"],
        managedByFeeds: json["managed_by_feeds"] == null ? null : json["managed_by_feeds"],
        permalink: json["permalink"],
        permalinkUrl: json["permalink_url"],
        public: json["public"] == null ? null : json["public"],
        repostsCount: json["reposts_count"] == null ? null : json["reposts_count"],
        secretToken: json["secret_token"],
        sharing: json["sharing"] == null ? null : sharingValues.map[json["sharing"]],
        title: json["title"],
        trackCount: json["track_count"] == null ? null : json["track_count"],
        uri: json["uri"] == null ? null : json["uri"],
        userId: json["user_id"] == null ? null : json["user_id"],
        setType: json["set_type"] == null ? null : setTypeValues.map[json["set_type"]],
        isAlbum: json["is_album"] == null ? null : json["is_album"],
        publishedAt: json["published_at"] == null ? null : DateTime.parse(json["published_at"]),
        displayDate: json["display_date"] == null ? null : DateTime.parse(json["display_date"]),
        user: User.fromJson(json["user"]),
        urn: json["urn"] == null ? null : json["urn"],
        queryUrn: json["query_urn"],
        description: json["description"] == null ? null : json["description"],
        shortTitle: json["short_title"] == null ? null : json["short_title"],
        shortDescription: json["short_description"] == null ? null : shortDescriptionValues.map[json["short_description"]],
        trackingFeatureName: json["tracking_feature_name"] == null ? null : trackingFeatureNameValues.map[json["tracking_feature_name"]],
        lastUpdated: json["last_updated"] == null ? null : DateTime.parse(json["last_updated"]),
        calculatedArtworkUrl: json["calculated_artwork_url"] == null ? null : json["calculated_artwork_url"],
        tracks: json["tracks"] == null ? null : List<Track>.from(json["tracks"].map((x) => Track.fromJson(x))),
        isPublic: json["is_public"] == null ? null : json["is_public"],
        madeFor: json["made_for"],
    );

    Map<String, dynamic> toJson() => {
        "artwork_url": artworkUrl == null ? null : artworkUrl,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "duration": duration == null ? null : duration,
        "id": id,
        "kind": collectionKindValues.reverse[kind],
        "last_modified": lastModified == null ? null : lastModified.toIso8601String(),
        "likes_count": likesCount == null ? null : likesCount,
        "managed_by_feeds": managedByFeeds == null ? null : managedByFeeds,
        "permalink": permalink,
        "permalink_url": permalinkUrl,
        "public": public == null ? null : public,
        "reposts_count": repostsCount == null ? null : repostsCount,
        "secret_token": secretToken,
        "sharing": sharing == null ? null : sharingValues.reverse[sharing],
        "title": title,
        "track_count": trackCount == null ? null : trackCount,
        "uri": uri == null ? null : uri,
        "user_id": userId == null ? null : userId,
        "set_type": setType == null ? null : setTypeValues.reverse[setType],
        "is_album": isAlbum == null ? null : isAlbum,
        "published_at": publishedAt == null ? null : publishedAt.toIso8601String(),
        "display_date": displayDate == null ? null : displayDate.toIso8601String(),
        "user": user.toJson(),
        "urn": urn == null ? null : urn,
        "query_urn": queryUrn,
        "description": description == null ? null : description,
        "short_title": shortTitle == null ? null : shortTitle,
        "short_description": shortDescription == null ? null : shortDescriptionValues.reverse[shortDescription],
        "tracking_feature_name": trackingFeatureName == null ? null : trackingFeatureNameValues.reverse[trackingFeatureName],
        "last_updated": lastUpdated == null ? null : lastUpdated.toIso8601String(),
        "calculated_artwork_url": calculatedArtworkUrl == null ? null : calculatedArtworkUrl,
        "tracks": tracks == null ? null : List<dynamic>.from(tracks.map((x) => x.toJson())),
        "is_public": isPublic == null ? null : isPublic,
        "made_for": madeFor,
    };
}

enum CollectionKind { PLAYLIST, SYSTEM_PLAYLIST }

final collectionKindValues = EnumValues({
    "playlist": CollectionKind.PLAYLIST,
    "system-playlist": CollectionKind.SYSTEM_PLAYLIST
});

enum SetType { EMPTY, COMPILATION }

final setTypeValues = EnumValues({
    "compilation": SetType.COMPILATION,
    "": SetType.EMPTY
});

enum Sharing { PUBLIC }

final sharingValues = EnumValues({
    "public": Sharing.PUBLIC
});

enum ShortDescription { NEW_HOT, TOP_50 }

final shortDescriptionValues = EnumValues({
    "New & hot": ShortDescription.NEW_HOT,
    "Top 50": ShortDescription.TOP_50
});

enum TrackingFeatureName { CHARTS_TRENDING, CHARTS_TOP }

final trackingFeatureNameValues = EnumValues({
    "charts-top": TrackingFeatureName.CHARTS_TOP,
    "charts-trending": TrackingFeatureName.CHARTS_TRENDING
});

class Track {
    Track({
        this.id,
        this.kind,
        this.monetizationModel,
        this.policy,
    });

    int id;
    TrackKind kind;
    MonetizationModel monetizationModel;
    Policy policy;

    factory Track.fromJson(Map<String, dynamic> json) => Track(
        id: json["id"],
        kind: trackKindValues.map[json["kind"]],
        monetizationModel: json["monetization_model"] == null ? null : monetizationModelValues.map[json["monetization_model"]],
        policy: json["policy"] == null ? null : policyValues.map[json["policy"]],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "kind": trackKindValues.reverse[kind],
        "monetization_model": monetizationModel == null ? null : monetizationModelValues.reverse[monetizationModel],
        "policy": policy == null ? null : policyValues.reverse[policy],
    };
}

enum TrackKind { TRACK }

final trackKindValues = EnumValues({
    "track": TrackKind.TRACK
});

enum MonetizationModel { NOT_APPLICABLE }

final monetizationModelValues = EnumValues({
    "NOT_APPLICABLE": MonetizationModel.NOT_APPLICABLE
});

enum Policy { ALLOW, SNIP }

final policyValues = EnumValues({
    "ALLOW": Policy.ALLOW,
    "SNIP": Policy.SNIP
});

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
    UserKind kind;
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
        kind: userKindValues.map[json["kind"]],
        lastModified: DateTime.parse(json["last_modified"]),
        lastName: json["last_name"],
        permalink: json["permalink"],
        permalinkUrl: json["permalink_url"],
        uri: json["uri"],
        urn: json["urn"],
        username: json["username"],
        verified: json["verified"],
        city: json["city"] == null ? null : json["city"],
        countryCode: json["country_code"] == null ? null : json["country_code"],
        badges: Badges.fromJson(json["badges"]),
    );

    Map<String, dynamic> toJson() => {
        "avatar_url": avatarUrl,
        "first_name": firstName,
        "full_name": fullName,
        "id": id,
        "kind": userKindValues.reverse[kind],
        "last_modified": lastModified.toIso8601String(),
        "last_name": lastName,
        "permalink": permalink,
        "permalink_url": permalinkUrl,
        "uri": uri,
        "urn": urn,
        "username": username,
        "verified": verified,
        "city": city == null ? null : city,
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

enum UserKind { USER }

final userKindValues = EnumValues({
    "user": UserKind.USER
});

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
