class PetEventModel {
  String? message;
  List<EventDatum>? eventData;

  PetEventModel({
    this.message,
    this.eventData,
  });

  factory PetEventModel.fromJson(Map<String, dynamic> json) => PetEventModel(
        message: json["message"],
        eventData: json["eventData"] == null
            ? []
            : List<EventDatum>.from(
                json["eventData"]!.map((x) => EventDatum.fromJson(x))),
      );
}

class EventDatum {
  String? id;
  String? image;
  String? name;
  String? description;
  DateTime? date;
  DateTime? time;
  String? location;
  bool? isExpired;

  EventDatum({
    this.id,
    this.image,
    this.name,
    this.description,
    this.date,
    this.time,
    this.location,
    this.isExpired,
  });

  factory EventDatum.fromJson(Map<String, dynamic> json) => EventDatum(
        id: json["_id"],
        image: json["image"],
        name: json["name"],
        description: json["description"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        time: json["time"] == null ? null : DateTime.parse(json["time"]),
        location: json["location"],
        isExpired: json["isExpired"],
      );
}
