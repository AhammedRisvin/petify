import '../../community home/model/get_community_home_model.dart';

class GetCommunityDetailsModel {
  bool? success;
  Message? message;

  GetCommunityDetailsModel({
    this.success,
    this.message,
  });

  factory GetCommunityDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetCommunityDetailsModel(
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
  List<LatestFeed>? feedsWithDetails;
  GroupDetails? groupDetails;

  Message({
    this.feedsWithDetails,
    this.groupDetails,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        feedsWithDetails: json["feedsWithDetails"] == null
            ? []
            : List<LatestFeed>.from(
                json["feedsWithDetails"]!.map((x) => LatestFeed.fromJson(x))),
        groupDetails: json["groupDetails"] == null
            ? null
            : GroupDetails.fromJson(json["groupDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "feedsWithDetails": feedsWithDetails == null
            ? []
            : List<dynamic>.from(feedsWithDetails!.map((x) => x.toJson())),
        "groupDetails": groupDetails?.toJson(),
      };
}

class Member {
  String? name;
  String? profile;

  Member({
    this.name,
    this.profile,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        name: json["name"],
        profile: json["profile"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "profile": profile,
      };
}

class GroupDetails {
  String? groupName;
  String? groupProfileImage;
  String? groupCoverImage;
  int? totalMembers;
  List<Member>? members;
  String? groupDescription;
  String? id;
  bool? isAdmin;
  String? shareLink;

  GroupDetails({
    this.groupName,
    this.groupProfileImage,
    this.groupCoverImage,
    this.totalMembers,
    this.members,
    this.groupDescription,
    this.id,
    this.isAdmin,
    this.shareLink,
  });

  factory GroupDetails.fromJson(Map<String, dynamic> json) => GroupDetails(
        groupName: json["groupName"],
        groupProfileImage: json["groupProfileImage"],
        groupCoverImage: json["groupCoverImage"],
        totalMembers: json["totalMembers"],
        members: json["members"] == null
            ? []
            : List<Member>.from(
                json["members"]!.map((x) => Member.fromJson(x))),
        groupDescription: json["groupDescription"],
        id: json["_id"],
        isAdmin: json["isAdmin"],
        shareLink: json["shareLink"],
      );

  Map<String, dynamic> toJson() => {
        "groupName": groupName,
        "groupProfileImage": groupProfileImage,
        "groupCoverImage": groupCoverImage,
        "totalMembers": totalMembers,
        "members": members == null
            ? []
            : List<dynamic>.from(members!.map((x) => x.toJson())),
        "groupDescription": groupDescription,
        "_id": id,
        "isAdmin": isAdmin,
        "shareLink": shareLink,
      };
}
