class GetChatsModel {
  bool? success;
  String? message;
  List<Chat>? chats;

  GetChatsModel({
    this.success,
    this.message,
    this.chats,
  });

  factory GetChatsModel.fromJson(Map<String, dynamic> json) => GetChatsModel(
        success: json["success"],
        message: json["message"],
        chats: json["chats"] == null
            ? []
            : List<Chat>.from(json["chats"]!.map((x) => Chat.fromJson(x))),
      );
}

class Chat {
  String? id;
  String? appId;
  List<User>? users;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  bool? deleted;
  LatestMessage? latestMessage;

  Chat({
    this.id,
    this.appId,
    this.users,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.deleted,
    this.latestMessage,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["_id"],
        appId: json["appId"],
        users: json["users"] == null
            ? []
            : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        deleted: json["deleted"],
        latestMessage: json["latestMessage"] == null
            ? null
            : LatestMessage.fromJson(json["latestMessage"]),
      );
}

class LatestMessage {
  String? id;
  String? appId;
  String? singleChat;
  Sender? sender;
  String? content;
  bool? deleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  LatestMessage({
    this.id,
    this.appId,
    this.singleChat,
    this.sender,
    this.content,
    this.deleted,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory LatestMessage.fromJson(Map<String, dynamic> json) => LatestMessage(
        id: json["_id"],
        appId: json["appId"],
        singleChat: json["singleChat"],
        sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
        content: json["content"],
        deleted: json["deleted"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );
}

class Sender {
  SenderPetShopUserDetails? petShopUserDetails;
  String? id;
  String? name;

  Sender({
    this.petShopUserDetails,
    this.id,
    this.name,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        petShopUserDetails: json["petShopUserDetails"] == null
            ? null
            : SenderPetShopUserDetails.fromJson(json["petShopUserDetails"]),
        id: json["_id"],
        name: json["name"],
      );
}

class SenderPetShopUserDetails {
  String? profile;

  SenderPetShopUserDetails({
    this.profile,
  });

  factory SenderPetShopUserDetails.fromJson(Map<String, dynamic> json) =>
      SenderPetShopUserDetails(
        profile: json["profile"],
      );

  Map<String, dynamic> toJson() => {
        "profile": profile,
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
}
