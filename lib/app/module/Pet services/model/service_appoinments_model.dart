// To parse this JSON data, do
//
//     final getServiceAppoinmentsModel = getServiceAppoinmentsModelFromJson(jsonString);

import 'dart:convert';

GetServiceAppoinmentsModel getServiceAppoinmentsModelFromJson(String str) =>
    GetServiceAppoinmentsModel.fromJson(json.decode(str));

String getServiceAppoinmentsModelToJson(GetServiceAppoinmentsModel data) =>
    json.encode(data.toJson());

class GetServiceAppoinmentsModel {
  bool? success;
  String? message;
  List<Appointment>? appointments;

  GetServiceAppoinmentsModel({
    this.success,
    this.message,
    this.appointments,
  });

  factory GetServiceAppoinmentsModel.fromJson(Map<String, dynamic> json) =>
      GetServiceAppoinmentsModel(
        success: json["success"],
        message: json["message"],
        appointments: json["appointments"] == null
            ? []
            : List<Appointment>.from(
                json["appointments"]!.map((x) => Appointment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "appointments": appointments == null
            ? []
            : List<dynamic>.from(appointments!.map((x) => x.toJson())),
      };
}

class Appointment {
  String? clinicName;
  String? clinicImage;
  DateTime? date;
  DateTime? startTime;
  DateTime? endTime;
  String? service;
  DateTime? serviceDate;
  String? status;
  String? bookingId;
  DateTime? requestedDate;
  String? petId;
  String? petName;
  String? petImage;

  Appointment({
    this.clinicName,
    this.clinicImage,
    this.date,
    this.startTime,
    this.endTime,
    this.service,
    this.serviceDate,
    this.status,
    this.bookingId,
    this.requestedDate,
    this.petId,
    this.petName,
    this.petImage,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        clinicName: json["clinicName"],
        clinicImage: json["clinicImage"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        startTime: json["startTime"] == null
            ? null
            : DateTime.parse(json["startTime"]),
        endTime:
            json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
        service: json["service"],
        serviceDate: json["serviceDate"] == null
            ? null
            : DateTime.parse(json["serviceDate"]),
        status: json["status"],
        bookingId: json["bookingId"],
        requestedDate: json["requestedDate"] == null
            ? null
            : DateTime.parse(json["requestedDate"]),
        petId: json["petId"],
        petName: json["petName"],
        petImage: json["petImage"],
      );

  Map<String, dynamic> toJson() => {
        "clinicName": clinicName,
        "clinicImage": clinicImage,
        "date": date?.toIso8601String(),
        "startTime": startTime?.toIso8601String(),
        "endTime": endTime?.toIso8601String(),
        "service": service,
        "serviceDate": serviceDate?.toIso8601String(),
        "status": status,
        "bookingId": bookingId,
        "requestedDate": requestedDate?.toIso8601String(),
        "petId": petId,
        "petName": petName,
        "petImage": petImage,
      };
}
