class GetCoParentModel {
  List<CoParent>? coParents;

  GetCoParentModel({
    this.coParents,
  });

  factory GetCoParentModel.fromJson(Map<String, dynamic> json) =>
      GetCoParentModel(
        coParents: json["coParents"] == null
            ? []
            : List<CoParent>.from(
                json["coParents"]!.map((x) => CoParent.fromJson(x))),
      );
}

class CoParent {
  PetShopUserDetails? petShopUserDetails;
  String? id;
  String? name;
  String? phoneNumber;

  CoParent({
    this.petShopUserDetails,
    this.id,
    this.name,
    this.phoneNumber,
  });

  factory CoParent.fromJson(Map<String, dynamic> json) => CoParent(
        petShopUserDetails: json["petShopUserDetails"] == null
            ? null
            : PetShopUserDetails.fromJson(json["petShopUserDetails"]),
        id: json["_id"],
        name: json["name"],
        phoneNumber: json["phoneNumber"],
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
