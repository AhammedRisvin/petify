import 'temmp_pets_model.dart';

class GetPetWithoutTempParentModel {
  List<TempPet>? petsWithoutTemporaryParents;

  GetPetWithoutTempParentModel({
    this.petsWithoutTemporaryParents,
  });

  factory GetPetWithoutTempParentModel.fromJson(Map<String, dynamic> json) =>
      GetPetWithoutTempParentModel(
        petsWithoutTemporaryParents: json["petsWithoutTemporaryParents"] == null
            ? []
            : List<TempPet>.from(json["petsWithoutTemporaryParents"]!
                .map((x) => TempPet.fromJson(x))),
      );
}
