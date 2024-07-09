// To parse this JSON data, do

class FetchAllMessagesModel {
  bool? success;
  List<MessageData>? message;

  FetchAllMessagesModel({
    this.success,
    this.message,
  });

  factory FetchAllMessagesModel.fromJson(Map<String, dynamic> json) =>
      FetchAllMessagesModel(
        success: json["success"],
        message: json["message"] == null
            ? []
            : List<MessageData>.from(
                json["message"]!.map((x) => MessageData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message == null
            ? []
            : List<dynamic>.from(message!.map((x) => x.toJson())),
      };
}

class MessageData {
  String? id;
  String? appId;
  String? chat;
  String? ext;
  String? image;
  Sender? sender;
  String? content;
  bool? deleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  MessageData({
    this.id,
    this.appId,
    this.chat,
    this.ext,
    this.image,
    this.sender,
    this.content,
    this.deleted,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory MessageData.fromJson(Map<String, dynamic> json) => MessageData(
        id: json["_id"],
        appId: json["appId"],
        chat: json["chat"],
        ext: json["ext"],
        image: json["image"],
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

  Map<String, dynamic> toJson() => {
        "_id": id,
        "appId": appId,
        "chat": chat,
        "ext": ext,
        "image": image,
        "sender": sender?.toJson(),
        "content": content,
        "deleted": deleted,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "__v": v,
      };
}

class Sender {
  PetShopUserDetails? petShopUserDetails;
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
