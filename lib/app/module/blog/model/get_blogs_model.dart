class GetBlogsModel {
  String? message;
  List<BlogData>? blogDatas;
  List<dynamic>? mostlyLikedBlogs;

  GetBlogsModel({
    this.message,
    this.blogDatas,
    this.mostlyLikedBlogs,
  });

  factory GetBlogsModel.fromJson(Map<String, dynamic> json) => GetBlogsModel(
        message: json["message"],
        blogDatas: json["blogDatas"] == null
            ? []
            : List<BlogData>.from(
                json["blogDatas"]!.map((x) => BlogData.fromJson(x))),
        mostlyLikedBlogs: json["mostlyLikedBlogs"] == null
            ? []
            : List<dynamic>.from(json["mostlyLikedBlogs"]!.map((x) => x)),
      );
}

class BlogData {
  String? id;
  String? userId;
  String? blogImage;
  String? title;
  String? blog;
  DateTime? createdAt;
  int? views;
  int? likes;
  int? shares;
  String? userName;
  String? userImage;

  BlogData({
    this.id,
    this.userId,
    this.blogImage,
    this.title,
    this.blog,
    this.createdAt,
    this.views,
    this.likes,
    this.shares,
    this.userName,
    this.userImage,
  });

  factory BlogData.fromJson(Map<String, dynamic> json) => BlogData(
        id: json["_id"],
        userId: json["userId"],
        blogImage: json["blogImage"],
        title: json["title"],
        blog: json["blog"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        views: json["views"],
        likes: json["likes"],
        shares: json["shares"],
        userName: json["userName"],
        userImage: json["userImage"],
      );
}
