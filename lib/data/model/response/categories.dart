class Categories {
  Categories({
    this.id,
    this.image,
    this.title,
    this.parentId,
  });

  int? id, parentId;
  String? title, image;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        id: json["id"],
        image: json["image"],
        title: json["title"],
        parentId: json["parent_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "title": title,
        "parent_id": parentId,
      };
}
