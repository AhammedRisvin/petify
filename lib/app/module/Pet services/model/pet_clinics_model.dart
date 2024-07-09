class GetPetClinicsModel {
  bool? success;
  String? message;
  List<Clinic>? clinics;

  GetPetClinicsModel({
    this.success,
    this.message,
    this.clinics,
  });

  factory GetPetClinicsModel.fromJson(Map<String, dynamic> json) =>
      GetPetClinicsModel(
        success: json["success"],
        message: json["message"],
        clinics: json["clinics"] == null
            ? []
            : List<Clinic>.from(
                json["clinics"]!.map((x) => Clinic.fromJson(x))),
      );
}

class Clinic {
  String? clinicId;
  String? clinicName;
  String? clinicImage;
  String? description;
  String? phone;
  Location? location;
  String? country;
  List<String>? services;

  Clinic({
    this.clinicId,
    this.clinicName,
    this.clinicImage,
    this.description,
    this.phone,
    this.location,
    this.country,
    this.services,
  });

  factory Clinic.fromJson(Map<String, dynamic> json) => Clinic(
        clinicId: json["clinicId"],
        clinicName: json["clinicName"],
        clinicImage: json["clinicImage"],
        description: json["description"],
        phone: json["phone"],
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        country: json["country"],
        services: json["services"] == null
            ? []
            : List<String>.from(json["services"]!.map((x) => x)),
      );
}

class Location {
  String? lat;
  String? lng;

  Location({
    this.lat,
    this.lng,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"],
        lng: json["lng"],
      );
}
