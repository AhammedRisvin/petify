class GetAllCommunitySearchModel {
  bool? success;
  String? message;
  List<Group>? groups;
  int? totalCount;

  GetAllCommunitySearchModel({
    this.success,
    this.message,
    this.groups,
    this.totalCount,
  });

  factory GetAllCommunitySearchModel.fromJson(Map<String, dynamic> json) =>
      GetAllCommunitySearchModel(
        success: json["success"],
        message: json["message"],
        groups: json["groups"] == null
            ? []
            : List<Group>.from(json["groups"]!.map((x) => Group.fromJson(x))),
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "groups": groups == null
            ? []
            : List<dynamic>.from(groups!.map((x) => x.toJson())),
        "totalCount": totalCount,
      };
}

class Group {
  String? id;
  List<UserElement>? users;
  String? groupProfileImage;
  String? groupCoverImage;
  String? groupName;
  String? groupDescription;
  String? createdAt;
  int? numberOfMembers;
  String? shareLink;

  Group({
    this.id,
    this.users,
    this.groupProfileImage,
    this.groupCoverImage,
    this.groupName,
    this.groupDescription,
    this.createdAt,
    this.numberOfMembers,
    this.shareLink,
  });

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["_id"],
        users: json["users"] == null
            ? []
            : List<UserElement>.from(
                json["users"]!.map((x) => UserElement.fromJson(x))),
        groupProfileImage: json["groupProfileImage"],
        groupCoverImage: json["groupCoverImage"],
        groupName: json["groupName"],
        groupDescription: json["groupDescription"],
        createdAt: json["createdAt"],
        numberOfMembers: json["numberOfMembers"],
        shareLink: json["shareLink"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "users": users == null
            ? []
            : List<dynamic>.from(users!.map((x) => x.toJson())),
        "groupProfileImage": groupProfileImage,
        "groupCoverImage": groupCoverImage,
        "groupName": groupName,
        "groupDescription": groupDescription,
        "createdAt": createdAt,
        "numberOfMembers": numberOfMembers,
        "shareLink": shareLink,
      };
}

class UserElement {
  UserUser? user;
  String? id;
  String? joinedAt;

  UserElement({
    this.user,
    this.id,
    this.joinedAt,
  });

  factory UserElement.fromJson(Map<String, dynamic> json) => UserElement(
        user: json["user"] == null ? null : UserUser.fromJson(json["user"]),
        id: json["_id"],
        joinedAt: json["joinedAt"],
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "_id": id,
        "joinedAt": joinedAt,
      };
}

class UserUser {
  PetShopUserDetails? petShopUserDetails;
  String? id;
  String? name;

  UserUser({
    this.petShopUserDetails,
    this.id,
    this.name,
  });

  factory UserUser.fromJson(Map<String, dynamic> json) => UserUser(
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
