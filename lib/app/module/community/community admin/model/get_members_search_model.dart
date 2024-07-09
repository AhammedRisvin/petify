import 'get_community_admin_model.dart';

class GetCommunityMemebersSearchModel {
  bool? success;
  String? message;
  List<UserElement>? users;

  GetCommunityMemebersSearchModel({
    this.success,
    this.message,
    this.users,
  });

  factory GetCommunityMemebersSearchModel.fromJson(Map<String, dynamic> json) =>
      GetCommunityMemebersSearchModel(
        success: json["success"],
        message: json["message"],
        users: json["users"] == null
            ? []
            : List<UserElement>.from(
                json["users"]!.map((x) => UserElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "users": users == null
            ? []
            : List<dynamic>.from(users!.map((x) => x.toJson())),
      };
}

// class UserElement {
//   UserUser? user;
//   String? joinedAt;

//   UserElement({
//     this.user,
//     this.joinedAt,
//   });

//   factory UserElement.fromJson(Map<String, dynamic> json) => UserElement(
//         user: json["user"] == null ? null : UserUser.fromJson(json["user"]),
//         joinedAt: json["joinedAt"],
//       );

//   Map<String, dynamic> toJson() => {
//         "user": user?.toJson(),
//         "joinedAt": joinedAt,
//       };
// }

// class UserUser {
//   String? id;
//   String? name;
//   PetShopUserDetails? petShopUserDetails;

//   UserUser({
//     this.id,
//     this.name,
//     this.petShopUserDetails,
//   });

//   factory UserUser.fromJson(Map<String, dynamic> json) => UserUser(
//         id: json["_id"],
//         name: json["name"],
//         petShopUserDetails: json["petShopUserDetails"] == null
//             ? null
//             : PetShopUserDetails.fromJson(json["petShopUserDetails"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "_id": id,
//         "name": name,
//         "petShopUserDetails": petShopUserDetails?.toJson(),
//       };
// }

// class PetShopUserDetails {
//   String? profile;

//   PetShopUserDetails({
//     this.profile,
//   });

//   factory PetShopUserDetails.fromJson(Map<String, dynamic> json) =>
//       PetShopUserDetails(
//         profile: json["profile"],
//       );

//   Map<String, dynamic> toJson() => {
//         "profile": profile,
//       };
// }
