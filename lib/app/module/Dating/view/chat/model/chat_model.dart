import '../../../../community/chat/model/chat_model.dart';

class GetPreviousChatModel {
  bool? success;
  List<MessageData>? message;

  GetPreviousChatModel({
    this.success,
    this.message,
  });

  factory GetPreviousChatModel.fromJson(Map<String, dynamic> json) =>
      GetPreviousChatModel(
        success: json["success"],
        message: json["message"] == null
            ? []
            : List<MessageData>.from(
                json["message"]!.map((x) => MessageData.fromJson(x))),
      );
}
