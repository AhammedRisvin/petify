class GetPetExpenceModel {
  List<Expence>? expences;
  int? totalExpenecs;

  GetPetExpenceModel({
    this.expences,
    this.totalExpenecs,
  });

  factory GetPetExpenceModel.fromJson(Map<String, dynamic> json) =>
      GetPetExpenceModel(
        expences: json["expences"] == null
            ? []
            : List<Expence>.from(
                json["expences"]!.map((x) => Expence.fromJson(x))),
        totalExpenecs: json["totalExpenecs"],
      );

  Map<String, dynamic> toJson() => {
        "expences": expences == null
            ? []
            : List<dynamic>.from(expences!.map((x) => x.toJson())),
        "totalExpenecs": totalExpenecs,
      };
}

class Expence {
  String? id;
  int? amount;
  String? name;
  DateTime? date;
  String? pet;
  String? currency;

  Expence({
    this.id,
    this.amount,
    this.name,
    this.date,
    this.pet,
    this.currency,
  });

  factory Expence.fromJson(Map<String, dynamic> json) => Expence(
        id: json["_id"],
        amount: json["amount"],
        name: json["name"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        pet: json["pet"],
        currency: json["currency"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "amount": amount,
        "name": name,
        "date": date?.toIso8601String(),
        "pet": pet,
        "currency": currency,
      };
}
