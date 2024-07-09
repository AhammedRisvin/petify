class ListOfChatScreenModel {
  bool? success;
  String? message;
  List<GroupsWithMessage>? groupsWithMessages;
  List<GroupsWithoutMessage>? groupsWithoutMessages;

  ListOfChatScreenModel({
    this.success,
    this.message,
    this.groupsWithMessages,
    this.groupsWithoutMessages,
  });

  factory ListOfChatScreenModel.fromJson(Map<String, dynamic> json) =>
      ListOfChatScreenModel(
        success: json["success"],
        message: json["message"],
        groupsWithMessages: json["groupsWithMessages"] == null
            ? []
            : List<GroupsWithMessage>.from(json["groupsWithMessages"]!
                .map((x) => GroupsWithMessage.fromJson(x))),
        groupsWithoutMessages: json["groupsWithoutMessages"] == null
            ? []
            : List<GroupsWithoutMessage>.from(json["groupsWithoutMessages"]!
                .map((x) => GroupsWithoutMessage.fromJson(x))),
      );
}

class GroupsWithMessage {
  String? id;
  String? appId;
  String? creator;
  List<String>? admins;
  List<UserElement>? users;
  String? groupProfileImage;
  String? groupCoverImage;
  String? groupName;
  String? groupDescription;
  bool? deleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  LatestMessage? latestMessage;
  bool? isActive;

  GroupsWithMessage({
    this.id,
    this.appId,
    this.creator,
    this.admins,
    this.users,
    this.groupProfileImage,
    this.groupCoverImage,
    this.groupName,
    this.groupDescription,
    this.deleted,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.latestMessage,
    this.isActive,
  });

  factory GroupsWithMessage.fromJson(Map<String, dynamic> json) =>
      GroupsWithMessage(
        id: json["_id"],
        appId: json["appId"],
        creator: json["creator"],
        admins: json["admins"] == null
            ? []
            : List<String>.from(json["admins"]!.map((x) => x)),
        users: json["users"] == null
            ? []
            : List<UserElement>.from(
                json["users"]!.map((x) => UserElement.fromJson(x))),
        groupProfileImage: json["groupProfileImage"],
        groupCoverImage: json["groupCoverImage"],
        groupName: json["groupName"],
        groupDescription: json["groupDescription"],
        deleted: json["deleted"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        latestMessage: json["latestMessage"] == null
            ? null
            : LatestMessage.fromJson(json["latestMessage"]),
        isActive: json["isActive"],
      );
}

class LatestMessage {
  String? id;
  String? sender;
  String? content;
  DateTime? createdAt;

  LatestMessage({
    this.id,
    this.sender,
    this.content,
    this.createdAt,
  });

  factory LatestMessage.fromJson(Map<String, dynamic> json) => LatestMessage(
        id: json["_id"],
        sender: json["sender"],
        content: json["content"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
      );
}

class UserElement {
  UserUser? user;
  String? id;
  DateTime? joinedAt;

  UserElement({
    this.user,
    this.id,
    this.joinedAt,
  });

  factory UserElement.fromJson(Map<String, dynamic> json) => UserElement(
        user: json["user"] == null ? null : UserUser.fromJson(json["user"]),
        id: json["_id"],
        joinedAt:
            json["joinedAt"] == null ? null : DateTime.parse(json["joinedAt"]),
      );
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
}

class GroupsWithoutMessage {
  String? groupId;
  String? groupName;
  String? groupProfileImage;
  String? groupCoverImage;
  int? totalUserCount;
  List<UsersWithProfilePic>? usersWithProfilePics;
  String? groupShareLink;

  GroupsWithoutMessage({
    this.groupId,
    this.groupName,
    this.groupProfileImage,
    this.groupCoverImage,
    this.totalUserCount,
    this.usersWithProfilePics,
    this.groupShareLink,
  });

  factory GroupsWithoutMessage.fromJson(Map<String, dynamic> json) =>
      GroupsWithoutMessage(
        groupId: json["groupId"],
        groupName: json["groupName"],
        groupProfileImage: json["groupProfileImage"],
        groupCoverImage: json["groupCoverImage"],
        totalUserCount: json["totalUserCount"],
        usersWithProfilePics: json["usersWithProfilePics"] == null
            ? []
            : List<UsersWithProfilePic>.from(json["usersWithProfilePics"]!
                .map((x) => UsersWithProfilePic.fromJson(x))),
        groupShareLink: json["groupShareLink"],
      );
}

class UsersWithProfilePic {
  String? profilePicture;

  UsersWithProfilePic({
    this.profilePicture,
  });

  factory UsersWithProfilePic.fromJson(Map<String, dynamic> json) =>
      UsersWithProfilePic(
        profilePicture: json["profilePicture"],
      );
}
