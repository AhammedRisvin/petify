class GetAdoptPetDetailsModel {
  bool? success;
  String? message;
  FeedDetails? feedDetails;
  bool? intrested;
  String? currencyCode;

  GetAdoptPetDetailsModel({
    this.success,
    this.message,
    this.feedDetails,
    this.intrested,
    this.currencyCode,
  });

  factory GetAdoptPetDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetAdoptPetDetailsModel(
        success: json["success"],
        message: json["message"],
        feedDetails: json["feedDetails"] == null
            ? null
            : FeedDetails.fromJson(json["feedDetails"]),
        intrested: json["intrested"],
        currencyCode: json["currencyCode"],
      );
}

class FeedDetails {
  String? id;
  String? appId;
  String? petName;
  String? breed;
  String? location;
  String? prize;
  String? gender;
  String? age;
  DateTime? birthday;
  String? weight;
  String? height;
  String? description;
  String? phone;

  FeedDetails({
    this.id,
    this.appId,
    this.petName,
    this.breed,
    this.location,
    this.prize,
    this.gender,
    this.age,
    this.birthday,
    this.weight,
    this.height,
    this.description,
    this.phone,
  });

  factory FeedDetails.fromJson(Map<String, dynamic> json) => FeedDetails(
        id: json["_id"],
        appId: json["appId"],
        petName: json["petName"],
        breed: json["breed"],
        location: json["location"],
        prize: json["prize"],
        gender: json["gender"],
        age: json["age"],
        birthday:
            json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
        weight: json["weight"],
        height: json["height"],
        description: json["description"],
        phone: json["phone"],
      );
}
