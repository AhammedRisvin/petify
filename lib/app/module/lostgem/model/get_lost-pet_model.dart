// ignore_for_file: file_names

class GetLostPetModel {
  bool? success;
  List<Pet>? pets;
  String? message;

  GetLostPetModel({
    this.success,
    this.pets,
    this.message,
  });

  factory GetLostPetModel.fromJson(Map<String, dynamic> json) =>
      GetLostPetModel(
        success: json["success"],
        pets: json["pets"] == null
            ? []
            : List<Pet>.from(json["pets"]!.map((x) => Pet.fromJson(x))),
        message: json["message"],
      );
}

class Pet {
  MissingDetails? missingDetails;
  String? id;
  String? name;
  String? status;

  Pet({
    this.missingDetails,
    this.id,
    this.name,
    this.status,
  });

  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
        missingDetails: json["missingDetails"] == null
            ? null
            : MissingDetails.fromJson(json["missingDetails"]),
        id: json["_id"],
        name: json["name"],
        status: json["status"],
      );
}

class MissingDetails {
  DateTime? date;
  String? location;
  String? ownerContact;
  String? identification;

  MissingDetails({
    this.date,
    this.location,
    this.ownerContact,
    this.identification,
  });

  factory MissingDetails.fromJson(Map<String, dynamic> json) => MissingDetails(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        location: json["location"],
        ownerContact: json["ownerContact"],
        identification: json["identification"],
      );
}
