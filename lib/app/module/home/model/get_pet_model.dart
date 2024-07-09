class GetPetModel {
  bool? success;
  String? message;
  List<PetData>? pets;

  GetPetModel({
    this.success,
    this.message,
    this.pets,
  });

  factory GetPetModel.fromJson(Map<String, dynamic> json) => GetPetModel(
        success: json["success"],
        message: json["message"],
        pets: json["pets"] == null
            ? []
            : List<PetData>.from(json["pets"]!.map((x) => PetData.fromJson(x))),
      );
}

class PetData {
  String? id;
  String? appId;
  String? name;
  String? nickName;
  String? copId;
  String? chipId;
  String? species;
  String? breed;
  String? sex;
  DateTime? birthDate;
  int? weight;
  int? height;
  String? parent;
  List<dynamic>? coParents;
  List<dynamic>? temporaryParents;
  String? image;
  String? coverImage;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  PetData({
    this.id,
    this.appId,
    this.name,
    this.nickName,
    this.species,
    this.chipId,
    this.copId,
    this.breed,
    this.sex,
    this.birthDate,
    this.weight,
    this.height,
    this.parent,
    this.coParents,
    this.temporaryParents,
    this.image,
    this.coverImage,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory PetData.fromJson(Map<String, dynamic> json) => PetData(
        id: json["_id"],
        appId: json["appId"],
        name: json["name"],
        nickName: json["nickName"],
        species: json["species"],
        chipId: json["chipId"],
        copId: json["copId"],
        breed: json["breed"],
        sex: json["sex"],
        birthDate: json["birthDate"] == null
            ? null
            : DateTime.parse(json["birthDate"]),
        weight: json["weight"],
        height: json["height"],
        parent: json["parent"],
        coParents: json["coParents"] == null
            ? []
            : List<dynamic>.from(json["coParents"]!.map((x) => x)),
        temporaryParents: json["temporaryParents"] == null
            ? []
            : List<dynamic>.from(json["temporaryParents"]!.map((x) => x)),
        image: json["image"],
        coverImage: json["coverImage"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );
}
