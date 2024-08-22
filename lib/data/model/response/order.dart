import 'package:hotel_services_app/data/model/response/food.dart';

class OrderModel {
  int? id;
  double? amount;
  String? status;
  DateTime? createdAt;
  String? cartLength;

  OrderModel(
      {this.id, this.amount, this.status, this.createdAt, this.cartLength});

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json['id'],
        amount: double.parse(json['amount'].toString()),
        status: json['order_status'],
        createdAt: DateTime.parse(json['created_at']),
        cartLength: json['cart_items'].toString(),
      );
}

class OrderDetailModel {
  int? id;
  double? amount;
  String? status;
  DateTime? createdAt;
  String? cartLength;
  List<CartItem>? cartItems;

  OrderDetailModel(
      {this.id,
      this.amount,
      this.status,
      this.createdAt,
      this.cartLength,
      this.cartItems});

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailModel(
        id: json['id'],
        amount: double.parse(json['amount'].toString()),
        status: json['order_status'],
        createdAt: DateTime.parse(json['created_at']),
        cartLength: json['cart_items'].toString(),
        cartItems: List<CartItem>.from(
            json['cart_items'].map((x) => CartItem.fromJson(x))),
      );
}

class CartItem {
  FoodModel food;
  int quantity;
  int? variationId;
  List<int>? addonIds;
  double total;

  CartItem({
    required this.food,
    required this.quantity,
    this.variationId,
    this.addonIds,
    required this.total,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      food: json['product'] != null
          ? FoodModel.fromJson(json['product'])
          : FoodModel(),
      quantity: json['quantity'],
      variationId: json['variation'],
      addonIds: json['addons'] != null
          ? List<int>.from(json['addons'].map((x) => x))
          : [],
      total: double.parse(json['total'].toString()),
    );
  }
}
