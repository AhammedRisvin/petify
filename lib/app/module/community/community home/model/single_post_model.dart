import 'get_community_home_model.dart';

class SinglePostModel {
  bool? success;
  Message? message;

  SinglePostModel({
    this.success,
    this.message,
  });

  factory SinglePostModel.fromJson(Map<String, dynamic> json) =>
      SinglePostModel(
        success: json["success"],
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message?.toJson(),
      };
}

class Message {
  String? id;
  String? appId;
  Group? group;
  String? caption;
  String? link;
  UploadedBy? uploadedBy;
  List<String>? post;
  bool? deleted;
  List<Comment>? comments;
  DateTime? createdAt;
  String? shareLink;
  int? totalLikes;
  int? totalComments;
  int? totalShares;
  bool? userLiked;
  bool? isMember;

  Message({
    this.id,
    this.appId,
    this.group,
    this.caption,
    this.link,
    this.uploadedBy,
    this.post,
    this.deleted,
    this.comments,
    this.createdAt,
    this.shareLink,
    this.totalLikes,
    this.totalComments,
    this.totalShares,
    this.userLiked,
    this.isMember,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["_id"],
        appId: json["appId"],
        group: json["group"] == null ? null : Group.fromJson(json["group"]),
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
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        shareLink: json["shareLink"],
        totalLikes: json["totalLikes"],
        totalComments: json["totalComments"],
        totalShares: json["totalShares"],
        userLiked: json["userLiked"],
        isMember: json["isMember"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "appId": appId,
        "group": group?.toJson(),
        "caption": caption,
        "link": link,
        "uploadedBy": uploadedBy?.toJson(),
        "post": post == null ? [] : List<dynamic>.from(post!.map((x) => x)),
        "deleted": deleted,
        "comments": comments == null
            ? []
            : List<dynamic>.from(comments!.map((x) => x.toJson())),
        "createdAt": createdAt?.toIso8601String(),
        "shareLink": shareLink,
        "totalLikes": totalLikes,
        "totalComments": totalComments,
        "totalShares": totalShares,
        "userLiked": userLiked,
        "isMember": isMember,
      };
}

class UploadedBy {
  PetShopUserDetails? petShopUserDetails;
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
            : PetShopUserDetails.fromJson(json["petShopUserDetails"]),
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "petShopUserDetails": petShopUserDetails?.toJson(),
        "_id": id,
        "name": name,
      };
}

class PetShopUserDetails {
  String? profile;

  PetShopUserDetails({
    this.profile,
  });

  factory PetShopUserDetails.fromJson(Map<String, dynamic> json) =>
      PetShopUserDetails(
        profile: json["profile"],
      );

  Map<String, dynamic> toJson() => {
        "profile": profile,
      };
}

class Group {
  String? id;
  String? name;
  String? profileImage;
  String? groupCoverImage;
  int? membersCount;

  Group({
    this.id,
    this.name,
    this.profileImage,
    this.groupCoverImage,
    this.membersCount,
  });

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["_id"],
        name: json["name"],
        profileImage: json["profileImage"],
        groupCoverImage: json["groupCoverImage"],
        membersCount: json["membersCount"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "profileImage": profileImage,
        "groupCoverImage": groupCoverImage,
        "membersCount": membersCount,
      };
}
