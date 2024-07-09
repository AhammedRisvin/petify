import 'get_community_home_model.dart';

class GetCommunitySearchModel {
  bool? success;
  String? message;
  List<Community>? groups;

  GetCommunitySearchModel({
    this.success,
    this.message,
    this.groups,
  });

  factory GetCommunitySearchModel.fromJson(Map<String, dynamic> json) =>
      GetCommunitySearchModel(
        success: json["success"],
        message: json["message"],
        groups: json["groups"] == null
            ? []
            : List<Community>.from(
                json["groups"]!.map((x) => Community.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "groups": groups == null
            ? []
            : List<dynamic>.from(groups!.map((x) => x.toJson())),
      };
}
