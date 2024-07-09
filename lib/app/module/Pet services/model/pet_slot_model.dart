class GetPetSlotModel {
  bool? success;
  String? message;
  List<SlotForBooking>? slotForBooking;
  List<FormDatum>? formData;
  List<Pet>? pets;

  GetPetSlotModel({
    this.success,
    this.message,
    this.slotForBooking,
    this.formData,
    this.pets,
  });

  factory GetPetSlotModel.fromJson(Map<String, dynamic> json) =>
      GetPetSlotModel(
        success: json["success"],
        message: json["message"],
        slotForBooking: json["slotForBooking"] == null
            ? []
            : List<SlotForBooking>.from(
                json["slotForBooking"]!.map((x) => SlotForBooking.fromJson(x))),
        formData: json["formData"] == null
            ? []
            : List<FormDatum>.from(
                json["formData"]!.map((x) => FormDatum.fromJson(x))),
        pets: json["pets"] == null
            ? []
            : List<Pet>.from(json["pets"]!.map((x) => Pet.fromJson(x))),
      );
}

class FormDatum {
  FileDetails? fileDetails;
  String? label;
  String? name;
  String? type;
  String? instruction;
  bool? mandatory;
  bool? hide;
  List<String>? choices;
  String? id;

  FormDatum({
    this.fileDetails,
    this.label,
    this.name,
    this.type,
    this.instruction,
    this.mandatory,
    this.hide,
    this.choices,
    this.id,
  });

  factory FormDatum.fromJson(Map<String, dynamic> json) => FormDatum(
        fileDetails: json["fileDetails"] == null
            ? null
            : FileDetails.fromJson(json["fileDetails"]),
        label: json["label"],
        name: json["name"],
        type: json["type"],
        instruction: json["instruction"],
        mandatory: json["mandatory"],
        hide: json["hide"],
        choices: json["choices"] == null
            ? []
            : List<String>.from(json["choices"]!.map((x) => x)),
        id: json["_id"],
      );
}

class FileDetails {
  List<String>? fileType;
  int? maxLimit;
  String? sizeIn;

  FileDetails({
    this.fileType,
    this.maxLimit,
    this.sizeIn,
  });

  factory FileDetails.fromJson(Map<String, dynamic> json) => FileDetails(
        fileType: json["fileType"] == null
            ? []
            : List<String>.from(json["fileType"]!.map((x) => x)),
        maxLimit: json["maxLimit"],
        sizeIn: json["sizeIn"],
      );
}

class Pet {
  String? id;
  String? name;

  Pet({
    this.id,
    this.name,
  });

  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
        id: json["_id"],
        name: json["name"],
      );
}

class SlotForBooking {
  String? slotId;
  DateTime? startTime;
  DateTime? endTime;
  String? subSlotId;

  SlotForBooking({
    this.slotId,
    this.startTime,
    this.endTime,
    this.subSlotId,
  });

  factory SlotForBooking.fromJson(Map<String, dynamic> json) => SlotForBooking(
        slotId: json["slotId"],
        startTime: json["startTime"] == null
            ? null
            : DateTime.parse(json["startTime"]),
        endTime:
            json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
        subSlotId: json["subSlotId"],
      );
}
