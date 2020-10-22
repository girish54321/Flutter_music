class SingerProfile {
  SingerProfile({
    this.avatarUrl,
    this.city,
    this.commentsCount,
    this.countryCode,
    this.createdAt,
    this.creatorSubscriptions,
    this.creatorSubscription,
    this.description,
    this.followersCount,
    this.followingsCount,
    this.firstName,
    this.fullName,
    this.groupsCount,
    this.id,
    this.kind,
    this.lastModified,
    this.lastName,
    this.likesCount,
    this.playlistLikesCount,
    this.permalink,
    this.permalinkUrl,
    this.playlistCount,
    this.repostsCount,
    this.trackCount,
    this.uri,
    this.urn,
    this.username,
    this.verified,
    this.visuals,
    this.badges,
  });

  String avatarUrl;
  String city;
  int commentsCount;
  String countryCode;
  DateTime createdAt;
  List<CreatorSubscription> creatorSubscriptions;
  CreatorSubscription creatorSubscription;
  String description;
  int followersCount;
  int followingsCount;
  String firstName;
  String fullName;
  int groupsCount;
  int id;
  String kind;
  DateTime lastModified;
  String lastName;
  int likesCount;
  int playlistLikesCount;
  String permalink;
  String permalinkUrl;
  int playlistCount;
  dynamic repostsCount;
  int trackCount;
  String uri;
  String urn;
  String username;
  bool verified;
  Visuals visuals;
  Badges badges;

  factory SingerProfile.fromJson(Map<String, dynamic> json) => SingerProfile(
        avatarUrl: json["avatar_url"],
        city: json["city"],
        commentsCount: json["comments_count"],
        countryCode: json["country_code"],
        createdAt: DateTime.parse(json["created_at"]),
        creatorSubscriptions: List<CreatorSubscription>.from(
            json["creator_subscriptions"]
                .map((x) => CreatorSubscription.fromJson(x))),
        creatorSubscription:
            CreatorSubscription.fromJson(json["creator_subscription"]),
        description: json["description"],
        followersCount: json["followers_count"],
        followingsCount: json["followings_count"],
        firstName: json["first_name"],
        fullName: json["full_name"],
        groupsCount: json["groups_count"],
        id: json["id"],
        kind: json["kind"],
        lastModified: DateTime.parse(json["last_modified"]),
        lastName: json["last_name"],
        likesCount: json["likes_count"],
        playlistLikesCount: json["playlist_likes_count"],
        permalink: json["permalink"],
        permalinkUrl: json["permalink_url"],
        playlistCount: json["playlist_count"],
        repostsCount: json["reposts_count"],
        trackCount: json["track_count"],
        uri: json["uri"],
        urn: json["urn"],
        username: json["username"],
        verified: json["verified"],
        visuals: Visuals.fromJson(json["visuals"]),
        badges: Badges.fromJson(json["badges"]),
      );

  Map<String, dynamic> toJson() => {
        "avatar_url": avatarUrl,
        "city": city,
        "comments_count": commentsCount,
        "country_code": countryCode,
        "created_at": createdAt.toIso8601String(),
        "creator_subscriptions":
            List<dynamic>.from(creatorSubscriptions.map((x) => x.toJson())),
        "creator_subscription": creatorSubscription.toJson(),
        "description": description,
        "followers_count": followersCount,
        "followings_count": followingsCount,
        "first_name": firstName,
        "full_name": fullName,
        "groups_count": groupsCount,
        "id": id,
        "kind": kind,
        "last_modified": lastModified.toIso8601String(),
        "last_name": lastName,
        "likes_count": likesCount,
        "playlist_likes_count": playlistLikesCount,
        "permalink": permalink,
        "permalink_url": permalinkUrl,
        "playlist_count": playlistCount,
        "reposts_count": repostsCount,
        "track_count": trackCount,
        "uri": uri,
        "urn": urn,
        "username": username,
        "verified": verified,
        "visuals": visuals.toJson(),
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

class CreatorSubscription {
  CreatorSubscription({
    this.product,
  });

  Product product;

  factory CreatorSubscription.fromJson(Map<String, dynamic> json) =>
      CreatorSubscription(
        product: Product.fromJson(json["product"]),
      );

  Map<String, dynamic> toJson() => {
        "product": product.toJson(),
      };
}

class Product {
  Product({
    this.id,
  });

  String id;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}

class Visuals {
  Visuals({
    this.urn,
    this.enabled,
    this.visuals,
    this.tracking,
  });

  String urn;
  bool enabled;
  List<Visual> visuals;
  dynamic tracking;

  factory Visuals.fromJson(Map<String, dynamic> json) => Visuals(
        urn: json["urn"],
        enabled: json["enabled"],
        visuals:
            List<Visual>.from(json["visuals"].map((x) => Visual.fromJson(x))),
        tracking: json["tracking"],
      );

  Map<String, dynamic> toJson() => {
        "urn": urn,
        "enabled": enabled,
        "visuals": List<dynamic>.from(visuals.map((x) => x.toJson())),
        "tracking": tracking,
      };
}

class Visual {
  Visual({
    this.urn,
    this.entryTime,
    this.visualUrl,
  });

  String urn;
  int entryTime;
  String visualUrl;

  factory Visual.fromJson(Map<String, dynamic> json) => Visual(
        urn: json["urn"],
        entryTime: json["entry_time"],
        visualUrl: json["visual_url"],
      );

  Map<String, dynamic> toJson() => {
        "urn": urn,
        "entry_time": entryTime,
        "visual_url": visualUrl,
      };
}
