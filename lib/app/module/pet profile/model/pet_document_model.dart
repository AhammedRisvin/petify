class GetPetDocumentModel {
  List<Document>? documents;

  GetPetDocumentModel({
    this.documents,
  });

  factory GetPetDocumentModel.fromJson(Map<String, dynamic> json) =>
      GetPetDocumentModel(
        documents: json["documents"] == null
            ? []
            : List<Document>.from(
                json["documents"]!.map((x) => Document.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "documents": documents == null
            ? []
            : List<dynamic>.from(documents!.map((x) => x.toJson())),
      };
}

class Document {
  String? id;
  String? title;
  List<String>? documents;

  Document({
    this.id,
    this.title,
    this.documents,
  });

  factory Document.fromJson(Map<String, dynamic> json) => Document(
        id: json["_id"],
        title: json["title"],
        documents: json["documents"] == null
            ? []
            : List<String>.from(json["documents"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "documents": documents == null
            ? []
            : List<dynamic>.from(documents!.map((x) => x)),
      };
}
