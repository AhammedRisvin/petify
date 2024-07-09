class GetDewarmingTrackerModel {
  String? message;
  List<DewarmingData>? dewarmingDatas;

  GetDewarmingTrackerModel({
    this.message,
    this.dewarmingDatas,
  });

  factory GetDewarmingTrackerModel.fromJson(Map<String, dynamic> json) =>
      GetDewarmingTrackerModel(
        message: json["message"],
        dewarmingDatas: json["dewarmingDatas"] == null
            ? []
            : List<DewarmingData>.from(
                json["dewarmingDatas"]!.map((x) => DewarmingData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "dewarmingDatas": dewarmingDatas == null
            ? []
            : List<dynamic>.from(dewarmingDatas!.map((x) => x.toJson())),
      };
}

class DewarmingData {
  String? id;
  String? image;
  String? vaccineName;
  DateTime? administrationDate;
  DateTime? dueDate;
  String? serialNumber;
  String? clinicName;
  String? remarks;

  DewarmingData({
    this.id,
    this.image,
    this.vaccineName,
    this.administrationDate,
    this.dueDate,
    this.serialNumber,
    this.clinicName,
    this.remarks,
  });

  factory DewarmingData.fromJson(Map<String, dynamic> json) => DewarmingData(
        id: json["_id"],
        image: json["image"],
        vaccineName: json["vaccineName"],
        administrationDate: json["administrationDate"] == null
            ? null
            : DateTime.parse(json["administrationDate"]),
        dueDate:
            json["dueDate"] == null ? null : DateTime.parse(json["dueDate"]),
        serialNumber: json["serialNumber"],
        clinicName: json["clinicName"],
        remarks: json["remarks"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "image": image,
        "vaccineName": vaccineName,
        "administrationDate": administrationDate?.toIso8601String(),
        "dueDate": dueDate?.toIso8601String(),
        "serialNumber": serialNumber,
        "clinicName": clinicName,
        "remarks": remarks,
      };
}
