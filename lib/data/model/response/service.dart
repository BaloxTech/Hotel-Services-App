class ServiceModel {
  ServiceModel({this.id, this.image, this.title, this.price, this.description});

  int? id;
  String? image;
  String? title;
  String? description;
  double? price;

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        id: json["id"],
        image: json["image"],
        title: json["title"],
        price: double.parse(json["price"].toString()),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "title": title,
        "price": price,
        "description": description,
      };
}
