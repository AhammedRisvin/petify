class GetCommunityHomeModel {
  bool? success;
  String? message;
  List<Community>? trendingGroups;
  List<Community>? joinedGroups;
  List<LatestFeed>? latestFeeds;
  List<Community>? myCommunity;

  GetCommunityHomeModel({
    this.success,
    this.message,
    this.trendingGroups,
    this.joinedGroups,
    this.latestFeeds,
    this.myCommunity,
  });

  factory GetCommunityHomeModel.fromJson(Map<String, dynamic> json) =>
      GetCommunityHomeModel(
        success: json["success"],
        message: json["message"],
        trendingGroups: json["trendingGroups"] == null
            ? []
            : List<Community>.from(
                json["trendingGroups"]!.map((x) => Community.fromJson(x))),
        joinedGroups: json["joinedGroups"] == null
            ? []
            : List<Community>.from(
                json["joinedGroups"]!.map((x) => Community.fromJson(x))),
        latestFeeds: json["latestFeeds"] == null
            ? []
            : List<LatestFeed>.from(
                json["latestFeeds"]!.map((x) => LatestFeed.fromJson(x))),
        myCommunity: json["myCommunity"] == null
            ? []
            : List<Community>.from(
                json["myCommunity"]!.map((x) => Community.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "trendingGroups": trendingGroups == null
            ? []
            : List<dynamic>.from(trendingGroups!.map((x) => x.toJson())),
        "joinedGroups": joinedGroups == null
            ? []
            : List<dynamic>.from(joinedGroups!.map((x) => x.toJson())),
        "latestFeeds": latestFeeds == null
            ? []
            : List<dynamic>.from(latestFeeds!.map((x) => x.toJson())),
        "myCommunity": myCommunity == null
            ? []
            : List<dynamic>.from(myCommunity!.map((x) => x.toJson())),
      };
}

class UsersDatum {
  String? id;
  String? name;
  UsersDatumPetShopUserDetails? petShopUserDetails;

  UsersDatum({
    this.id,
    this.name,
    this.petShopUserDetails,
  });

  factory UsersDatum.fromJson(Map<String, dynamic> json) => UsersDatum(
        id: json["_id"],
        name: json["name"],
        petShopUserDetails: json["petShopUserDetails"] == null
            ? null
            : UsersDatumPetShopUserDetails.fromJson(json["petShopUserDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "petShopUserDetails": petShopUserDetails?.toJson(),
      };
}

class UsersDatumPetShopUserDetails {
  String? profile;

  UsersDatumPetShopUserDetails({
    this.profile,
  });

  factory UsersDatumPetShopUserDetails.fromJson(Map<String, dynamic> json) =>
      UsersDatumPetShopUserDetails(
        profile: json["profile"],
      );

  Map<String, dynamic> toJson() => {
        "profile": profile,
      };
}

class LatestFeed {
  String? id;
  String? appId;
  String? group;
  String? caption;
  String? link;
  UploadedBy? uploadedBy;
  List<String>? post;
  bool? deleted;
  List<Comment>? comments;
  int? totalLikes;
  bool? userLiked;
  int? totalComments;
  int? totalShares;
  String? shareLink;
  String? groupShareLink;

  LatestFeed({
    this.id,
    this.appId,
    this.group,
    this.caption,
    this.link,
    this.uploadedBy,
    this.post,
    this.deleted,
    this.comments,
    this.totalLikes,
    this.userLiked,
    this.totalComments,
    this.totalShares,
    this.shareLink,
    this.groupShareLink,
  });

  factory LatestFeed.fromJson(Map<String, dynamic> json) => LatestFeed(
        id: json["_id"],
        appId: json["appId"],
        group: json["group"],
        caption: json["caption"],
        link: json["link"],
        uploadedBy: json["uploadedBy"] == null
            ? null
            : UploadedBy.fromJson(json["uploadedBy"]),
        post: json["post"] == null
            ? []
            : List<String>.from(json["post"]!.map((x) => x)),
        deleted: json["deleted"],
        comments: json["comments"] == null
            ? []
            : List<Comment>.from(
                json["comments"]!.map((x) => Comment.fromJson(x))),
        totalLikes: json["totalLikes"],
        userLiked: json["userLiked"],
        totalComments: json["totalComments"],
        totalShares: json["totalShares"],
        shareLink: json["shareLink"],
        groupShareLink: json["groupShareLink"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "appId": appId,
        "group": group,
        "caption": caption,
        "link": link,
        "uploadedBy": uploadedBy?.toJson(),
        "post": post == null ? [] : List<dynamic>.from(post!.map((x) => x)),
        "deleted": deleted,
        "comments": comments == null
            ? []
            : List<dynamic>.from(comments!.map((x) => x.toJson())),
        "totalLikes": totalLikes,
        "userLiked": userLiked,
        "totalComments": totalComments,
        "totalShares": totalShares,
        "shareLink": shareLink,
        "groupShareLink": groupShareLink,
      };
}

class Comment {
  User? user;
  String? text;
  String? date;
  String? id;

  Comment({
    this.user,
    this.text,
    this.date,
    this.id,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        text: json["text"],
        date: json["date"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "text": text,
        "date": date,
        "_id": id,
      };
}

class User {
  UserPetShopUserDetails? petShopUserDetails;
  String? id;
  String? name;

  User({
    this.petShopUserDetails,
    this.id,
    this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        petShopUserDetails: json["petShopUserDetails"] == null
            ? null
            : UserPetShopUserDetails.fromJson(json["petShopUserDetails"]),
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "petShopUserDetails": petShopUserDetails?.toJson(),
        "_id": id,
        "name": name,
      };
}

class UserPetShopUserDetails {
  String? profile;

  UserPetShopUserDetails({
    this.profile,
  });

  factory UserPetShopUserDetails.fromJson(Map<String, dynamic> json) =>
      UserPetShopUserDetails(
        profile: json["profile"],
      );

  Map<String, dynamic> toJson() => {
        "profile": profile,
      };
}

class UploadedBy {
  UsersDatumPetShopUserDetails? petShopUserDetails;
  String? id;
  String? name;

  UploadedBy({
    this.petShopUserDetails,
    this.id,
    this.name,
  });

  factory UploadedBy.fromJson(Map<String, dynamic> json) => UploadedBy(
        petShopUserDetails: json["petShopUserDetails"] == null
            ? null
            : UsersDatumPetShopUserDetails.fromJson(json["petShopUserDetails"]),
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "petShopUserDetails": petShopUserDetails?.toJson(),
        "_id": id,
        "name": name,
      };
}

class Community {
  String? id;
  String? groupName;
  String? groupDescription;
  String? groupProfileImage;
  String? groupCoverImage;
  int? numberOfMembers;
  List<UsersDatum>? usersData;
  String? createdAt;
  String? shareLink;

  Community({
    this.id,
    this.groupName,
    this.groupDescription,
    this.groupProfileImage,
    this.groupCoverImage,
    this.numberOfMembers,
    this.usersData,
    this.createdAt,
    this.shareLink,
  });

  factory Community.fromJson(Map<String, dynamic> json) => Community(
        id: json["_id"],
        groupName: json["groupName"],
        groupDescription: json["groupDescription"],
        groupProfileImage: json["groupProfileImage"],
        groupCoverImage: json["groupCoverImage"],
        numberOfMembers: json["numberOfMembers"],
        usersData: json["usersData"] == null
            ? []
            : List<UsersDatum>.from(
                json["usersData"]!.map((x) => UsersDatum.fromJson(x))),
        createdAt: json["createdAt"],
        shareLink: json["shareLink"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "groupName": groupName,
        "groupDescription": groupDescription,
        "groupProfileImage": groupProfileImage,
        "groupCoverImage": groupCoverImage,
        "numberOfMembers": numberOfMembers,
        "usersData": usersData == null
            ? []
            : List<dynamic>.from(usersData!.map((x) => x.toJson())),
        "createdAt": createdAt,
        "shareLink": shareLink,
      };
}
