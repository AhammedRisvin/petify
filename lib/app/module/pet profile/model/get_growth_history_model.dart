class GetGrowthDataHistoryModel {
  String? message;
  List<AllGrowthDatum>? allGrowthData;

  GetGrowthDataHistoryModel({
    this.message,
    this.allGrowthData,
  });

  factory GetGrowthDataHistoryModel.fromJson(Map<String, dynamic> json) =>
      GetGrowthDataHistoryModel(
        message: json["message"],
        allGrowthData: json["allGrowthData"] == null
            ? []
            : List<AllGrowthDatum>.from(
                json["allGrowthData"]!.map((x) => AllGrowthDatum.fromJson(x))),
      );
}

class AllGrowthDatum {
  DateTime? date;
  int? value;
  String? unit;
  String? type;
  String? id;

  AllGrowthDatum({
    this.date,
    this.value,
    this.unit,
    this.type,
    this.id,
  });

  factory AllGrowthDatum.fromJson(Map<String, dynamic> json) => AllGrowthDatum(
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        value: json["value"],
        unit: json["unit"],
        type: json["type"],
        id: json["id"],
      );
}
