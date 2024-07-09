class GetAllAdoptionPetModel {
  bool? success;
  String? message;
  List<Feed>? feeds;
  List<String>? speciesList;
  int? totalCount;

  GetAllAdoptionPetModel({
    this.success,
    this.message,
    this.feeds,
    this.speciesList,
    this.totalCount,
  });

  factory GetAllAdoptionPetModel.fromJson(Map<String, dynamic> json) =>
      GetAllAdoptionPetModel(
        success: json["success"],
        message: json["message"],
        feeds: json["feeds"] == null
            ? []
            : List<Feed>.from(json["feeds"]!.map((x) => Feed.fromJson(x))),
        speciesList: json["speciesList"] == null
            ? []
            : List<String>.from(json["speciesList"]!.map((x) => x)),
        totalCount: json["totalCount"],
      );
}

class Feed {
  String? id;
  String? appId;
  String? petName;
  String? image;
  String? gender;
  String? age;
  DateTime? birthday;

  Feed({
    this.id,
    this.appId,
    this.petName,
    this.image,
    this.gender,
    this.age,
    this.birthday,
  });

  factory Feed.fromJson(Map<String, dynamic> json) => Feed(
        id: json["_id"],
        appId: json["appId"],
        petName: json["petName"],
        image: json["image"],
        gender: json["gender"],
        age: json["age"],
        birthday:
            json["birthday"] == null ? null : DateTime.parse(json["birthday"]),
      );
}
