import 'package:hotel_services_app/data/model/response/addons.dart';

import 'food.dart';

class CartModel {
  final FoodModel food;
  final String quantity;
  final double price;
  final double total;
  final List<Addon> addons;
  final Addon variations;

  CartModel({
    required this.food,
    required this.quantity,
    required this.price,
    required this.total,
    required this.addons,
    required this.variations,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      food: FoodModel.fromJson(json['food']),
      quantity: json['quantity'],
      price: json['price'],
      total: json['total'],
      addons: json['addons'] != null
          ? List<Addon>.from(json['addons'].map((x) => Addon.fromJson(x)))
          : [],
      variations: Addon.fromJson(json['variations']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'food': food.toJson(),
      'quantity': quantity,
      'price': price,
      'total': total,
      'addons': List<Addon>.from(addons.map((x) => x.toJson())),
      'variations': variations.toJson(),
    };
  }
}
