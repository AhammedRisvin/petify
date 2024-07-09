// To parse this JSON data, do
//
//     final getPetGrowthModel = getPetGrowthModelFromJson(jsonString);

import 'dart:convert';

GetPetGrowthModel getPetGrowthModelFromJson(String str) =>
    GetPetGrowthModel.fromJson(json.decode(str));

String getPetGrowthModelToJson(GetPetGrowthModel data) =>
    json.encode(data.toJson());

class GetPetGrowthModel {
  String? message;
  List<EightsDatum>? weightsData;
  List<EightsDatum>? heightsData;
  bool? isNotWeight;
  bool? isNotHeight;

  GetPetGrowthModel({
    this.message,
    this.weightsData,
    this.heightsData,
    this.isNotWeight,
    this.isNotHeight,
  });

  factory GetPetGrowthModel.fromJson(Map<String, dynamic> json) =>
      GetPetGrowthModel(
        message: json["message"],
        weightsData: json["weightsData"] == null
            ? []
            : List<EightsDatum>.from(
                json["weightsData"]!.map((x) => EightsDatum.fromJson(x))),
        heightsData: json["heightsData"] == null
            ? []
            : List<EightsDatum>.from(
                json["heightsData"]!.map((x) => EightsDatum.fromJson(x))),
        isNotWeight: json["isNotWeight"],
        isNotHeight: json["isNotHeight"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "weightsData": weightsData == null
            ? []
            : List<dynamic>.from(weightsData!.map((x) => x.toJson())),
        "heightsData": heightsData == null
            ? []
            : List<dynamic>.from(heightsData!.map((x) => x.toJson())),
        "isNotWeight": isNotWeight,
        "isNotHeight": isNotHeight,
      };
}

class EightsDatum {
  DateTime? date;
  int? value;
  String? unit;
  String? name;

  EightsDatum({
    this.date,
    this.value,
    this.unit,
    this.name,
  });

  factory EightsDatum.fromJson(Map<String, dynamic> json) => EightsDatum(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        value: json["value"],
        unit: json["unit"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "value": value,
        "unit": unit,
        "name": name,
      };
}
