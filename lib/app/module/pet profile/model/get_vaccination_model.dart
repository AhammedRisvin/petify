import 'get_dewarming_model.dart';

class GetVaccinationTrackerModel {
  bool? success;
  List<DewarmingData>? vaccinations;

  GetVaccinationTrackerModel({
    this.success,
    this.vaccinations,
  });

  factory GetVaccinationTrackerModel.fromJson(Map<String, dynamic> json) =>
      GetVaccinationTrackerModel(
        success: json["success"],
        vaccinations: json["vaccinations"] == null
            ? []
            : List<DewarmingData>.from(
                json["vaccinations"]!.map((x) => DewarmingData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "vaccinations": vaccinations == null
            ? []
            : List<dynamic>.from(vaccinations!.map((x) => x.toJson())),
      };
}
