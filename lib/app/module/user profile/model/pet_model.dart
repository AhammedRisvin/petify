class PetModel {
  bool? success;
  String? message;
  List<Pet>? pets;

  PetModel({
    this.success,
    this.message,
    this.pets,
  });

  factory PetModel.fromJson(Map<String, dynamic> json) => PetModel(
        success: json["success"],
        message: json["message"],
        pets: json["pets"] == null
            ? []
            : List<Pet>.from(json["pets"]!.map((x) => Pet.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "pets": pets == null
            ? []
            : List<dynamic>.from(pets!.map((x) => x.toJson())),
      };
}

class Pet {
  String? id;
  String? name;
  String? nickName;

  Pet({
    this.id,
    this.name,
    this.nickName,
  });

  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
        id: json["_id"],
        name: json["name"],
        nickName: json["nickName"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "nickName": nickName,
      };
}
