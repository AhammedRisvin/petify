class GetCommunityAdminModel {
  bool? success;
  Message? message;

  GetCommunityAdminModel({
    this.success,
    this.message,
  });

  factory GetCommunityAdminModel.fromJson(Map<String, dynamic> json) =>
      GetCommunityAdminModel(
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
  GroupDetails? groupDetails;

  Message({
    this.groupDetails,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        groupDetails: json["groupDetails"] == null
            ? null
            : GroupDetails.fromJson(json["groupDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "groupDetails": groupDetails?.toJson(),
      };
}

class GroupDetails {
  String? groupName;
  String? groupProfileImage;
  String? groupCoverImage;
  int? totalMembers;
  String? groupDescription;
  String? id;
  bool? isAdmin;
  String? creator;
  List<UserElement>? users;

  GroupDetails({
    this.groupName,
    this.groupProfileImage,
    this.groupCoverImage,
    this.totalMembers,
    this.groupDescription,
    this.id,
    this.isAdmin,
    this.creator,
    this.users,
  });

  factory GroupDetails.fromJson(Map<String, dynamic> json) => GroupDetails(
        groupName: json["groupName"],
        groupProfileImage: json["groupProfileImage"],
        groupCoverImage: json["groupCoverImage"],
        totalMembers: json["totalMembers"],
        groupDescription: json["groupDescription"],
        id: json["_id"],
        isAdmin: json["isAdmin"],
        creator: json["creator"],
        users: json["users"] == null
            ? []
            : List<UserElement>.from(
                json["users"]!.map((x) => UserElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "groupName": groupName,
        "groupProfileImage": groupProfileImage,
        "groupCoverImage": groupCoverImage,
        "totalMembers": totalMembers,
        "groupDescription": groupDescription,
        "_id": id,
        "isAdmin": isAdmin,
        "creator": creator,
        "users": users == null
            ? []
            : List<dynamic>.from(users!.map((x) => x.toJson())),
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
