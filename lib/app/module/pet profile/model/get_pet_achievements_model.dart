class GetAchievementsModel {
  bool? success;
  String? message;
  List<Achievment>? achievments;

  GetAchievementsModel({
    this.success,
    this.message,
    this.achievments,
  });

  factory GetAchievementsModel.fromJson(Map<String, dynamic> json) =>
      GetAchievementsModel(
        success: json["success"],
        message: json["message"],
        achievments: json["achievments"] == null
            ? []
            : List<Achievment>.from(
                json["achievments"]!.map((x) => Achievment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "achievments": achievments == null
            ? []
            : List<dynamic>.from(achievments!.map((x) => x.toJson())),
      };
}

class Achievment {
  String? id;
  String? name;
  String? venue;
  DateTime? date;
  String? organisation;
  String? pet;

  Achievment({
    this.id,
    this.name,
    this.venue,
    this.date,
    this.organisation,
    this.pet,
  });

  factory Achievment.fromJson(Map<String, dynamic> json) => Achievment(
        id: json["_id"],
        name: json["name"],
        venue: json["venue"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        organisation: json["organisation"],
        pet: json["pet"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "venue": venue,
        "date": date?.toIso8601String(),
        "organisation": organisation,
        "pet": pet,
      };
}
