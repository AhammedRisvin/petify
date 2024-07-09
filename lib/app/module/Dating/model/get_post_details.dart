class GetDatePostDetailsModel {
  bool? success;
  Message? message;

  GetDatePostDetailsModel({
    this.success,
    this.message,
  });

  factory GetDatePostDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetDatePostDetailsModel(
        success: json["success"],
        message:
            json["message"] == null ? null : Message.fromJson(json["message"]),
      );
}

class Message {
  String? id;
  String? appId;
  String? name;
  String? species;
  String? shareLink;
  String? age;
  String? breed;
  String? gender;
  DateTime? birthdate;
  String? weight;
  String? height;
  String? location;
  String? latitude;
  String? longitude;
  String? lookingFor;
  String? image;
  UploadedBy? uploadedBy;
  bool? deleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Message({
    this.id,
    this.appId,
    this.name,
    this.species,
    this.shareLink,
    this.age,
    this.breed,
    this.gender,
    this.birthdate,
    this.weight,
    this.height,
    this.location,
    this.latitude,
    this.longitude,
    this.lookingFor,
    this.image,
    this.uploadedBy,
    this.deleted,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["_id"],
        appId: json["appId"],
        name: json["name"],
        species: json["species"],
        shareLink: json["shareLink"],
        age: json["age"],
        breed: json["breed"],
        gender: json["gender"],
        birthdate: json["birthdate"] == null
            ? null
            : DateTime.parse(json["birthdate"]),
        weight: json["weight"],
        height: json["height"],
        location: json["location"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        lookingFor: json["lookingFor"],
        image: json["image"],
        uploadedBy: json["uploadedBy"] == null
            ? null
            : UploadedBy.fromJson(json["uploadedBy"]),
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
