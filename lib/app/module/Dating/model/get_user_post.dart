import 'get_all_post.dart';

class GetUserPostModel {
  bool? success;
  String? message;
  List<Post>? posts;

  GetUserPostModel({
    this.success,
    this.message,
    this.posts,
  });

  factory GetUserPostModel.fromJson(Map<String, dynamic> json) =>
      GetUserPostModel(
        success: json["success"],
        message: json["message"],
        posts: json["posts"] == null
            ? []
            : List<Post>.from(json["posts"]!.map((x) => Post.fromJson(x))),
      );
}
