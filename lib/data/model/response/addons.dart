class Addon {
  Addon({this.id, this.name, this.price});

  int? id;
  String? name;
  double? price;

  factory Addon.fromJson(Map<String, dynamic> json) => Addon(
      id: json["id"],
      name: json["name"],
      price: double.parse(json["price"].toString()));

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
      };
}
