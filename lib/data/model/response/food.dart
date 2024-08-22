import 'dart:convert';

import 'package:hotel_services_app/data/model/response/addons.dart';

class FoodModel {
  FoodModel(
      {this.id,
      this.category,
      this.subCategory,
      this.imageUrl,
      this.title,
      this.description,
      this.price,
      this.rating,
      this.varations,
      this.addons});

  int? id, subCategory, category;
  String? imageUrl;
  String? title, description;
  double? rating;
  double? price;
  List<Addon>? varations;
  List<Addon>? addons;

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
        id: json["id"],
        category: json["category_id"],
        subCategory: json["subcategory_id"],
        imageUrl: json["image"],
        title: json["title"],
        price: double.parse(json["price"].toString()),
        rating: json["rating"],
        description: json["description"],
        addons: json["addons"] != null
            ? List<Addon>.from(json['addons'] is String
                ? jsonDecode(json["addons"]).map((x) => Addon.fromJson(x))
                : json["addons"].map((x) => Addon.fromJson(x)))
            : [],
        varations: json["variations"] != null
            ? List<Addon>.from(json["variations"].map((x) => Addon.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": category,
        "subcategory_id": subCategory,
        "image": imageUrl,
        "title": title,
        "price": price,
        "rating": rating,
        "description": description,
        "addons": addons != null
            ? List<Addon>.from(addons!.map((x) => x.toJson()))
            : [],
        "variations": varations != null
            ? List<Addon>.from(varations!.map((x) => x.toJson()))
            : [],
      };
}
