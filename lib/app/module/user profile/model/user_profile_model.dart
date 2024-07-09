class GetUserProfileModel {
  bool? success;
  UserDetails? details;
  String? link;

  GetUserProfileModel({
    this.success,
    this.link,
    this.details,
  });

  factory GetUserProfileModel.fromJson(Map<String, dynamic> json) =>
      GetUserProfileModel(
        success: json["success"],
        link: json["link"],
        details: json["details"] == null
            ? null
            : UserDetails.fromJson(json["details"]),
      );
}

class UserDetails {
  String? firstName;
  String? lastName;
  String? nationality;
  String? country;
  String? city;
  String? language;
  String? timeZone;
  String? profile;
  String? coverImage;
  num? pets;
  num? temporaryParents;
  num? coParents;

  UserDetails({
    this.firstName,
    this.lastName,
    this.nationality,
    this.country,
    this.city,
    this.language,
    this.timeZone,
    this.profile,
    this.coverImage,
    this.pets,
    this.temporaryParents,
    this.coParents,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => UserDetails(
        firstName: json["firstName"],
        lastName: json["lastName"],
        nationality: json["nationality"],
        country: json["country"],
        city: json["city"],
        language: json["language"],
        timeZone: json["timeZone"],
        profile: json["profile"],
        coverImage: json["coverImage"],
        pets: json["pets"],
        temporaryParents: json["temporaryParents"],
        coParents: json["coParents"],
      );
}
