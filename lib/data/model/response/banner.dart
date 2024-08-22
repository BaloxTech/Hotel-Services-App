import 'package:hotel_services_app/data/model/response/food.dart';

class Banners {
  Banners({
    this.id,
    this.image,
    this.title,
    this.item,
  });

  int? id;
  String? title, image;
  FoodModel? item;

  factory Banners.fromJson(Map<String, dynamic> json) => Banners(
      id: json["item_id"],
      image: json["image"],
      title: json["title"],
      item: json['item'] == null ? null : FoodModel.fromJson(json['item']));

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "item_id": title,
      };
}
