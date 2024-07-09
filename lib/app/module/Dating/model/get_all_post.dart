class GetDateAllPostModel {
  bool? success;
  String? message;
  List<Post>? posts;
  List<SpeciesList>? speciesList;

  GetDateAllPostModel({
    this.success,
    this.message,
    this.posts,
    this.speciesList,
  });

  factory GetDateAllPostModel.fromJson(Map<String, dynamic> json) =>
      GetDateAllPostModel(
        success: json["success"],
        message: json["message"],
        posts: json["posts"] == null
            ? []
            : List<Post>.from(json["posts"]!.map((x) => Post.fromJson(x))),
        speciesList: json["speciesList"] == null
            ? []
            : List<SpeciesList>.from(
                json["speciesList"]!.map((x) => SpeciesList.fromJson(x))),
      );
}

class Post {
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
  String? uploadedBy;
  bool? deleted;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  Post({
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

  factory Post.fromJson(Map<String, dynamic> json) => Post(
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
        uploadedBy: json["uploadedBy"],
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

class SpeciesList {
  String? species;

  SpeciesList({
    this.species,
  });

  factory SpeciesList.fromJson(Map<String, dynamic> json) => SpeciesList(
        species: json["species"],
      );
}
