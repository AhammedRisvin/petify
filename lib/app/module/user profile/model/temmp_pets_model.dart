class GetTempParentPetModel {
  List<TempPet>? pets;

  GetTempParentPetModel({
    this.pets,
  });

  factory GetTempParentPetModel.fromJson(Map<String, dynamic> json) =>
      GetTempParentPetModel(
        pets: json["pets"] == null
            ? []
            : List<TempPet>.from(json["pets"]!.map((x) => TempPet.fromJson(x))),
      );
}

class TempPet {
  String? id;
  String? appId;
  String? copId;
  String? chipId;
  String? name;
  String? nickName;
  String? species;
  String? breed;
  String? sex;
  DateTime? birthDate;
  int? weight;
  int? height;
  String? parent;
  List<String>? coParents;
  List<String>? temporaryParents;
  String? image;
  String? coverImage;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  TempPet({
    this.id,
    this.appId,
    this.copId,
    this.chipId,
    this.name,
    this.nickName,
    this.species,
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

  factory TempPet.fromJson(Map<String, dynamic> json) => TempPet(
        id: json["_id"],
        appId: json["appId"],
        copId: json["copId"],
        chipId: json["chipId"],
        name: json["name"],
        nickName: json["nickName"],
        species: json["species"],
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
            : List<String>.from(json["coParents"]!.map((x) => x)),
        temporaryParents: json["temporaryParents"] == null
            ? []
            : List<String>.from(json["temporaryParents"]!.map((x) => x)),
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
