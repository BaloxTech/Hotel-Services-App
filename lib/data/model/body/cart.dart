class CartItem {
  int prodctId, quantity;
  int? variationId;
  List<int>? addonIds;
  double total;

  CartItem({
    required this.prodctId,
    required this.quantity,
    this.variationId,
    this.addonIds,
    required this.total,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      prodctId: json['product_id'],
      quantity: json['quantity'],
      variationId: json['variation_id'],
      addonIds: json['addon_ids'] != null
          ? List<int>.from(json['addon_ids'].map((x) => x))
          : [],
      total: double.parse(json['total'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': prodctId,
      'quantity': quantity,
      'variation_id': variationId,
      'addon_ids': addonIds,
      'total': total,
    };
  }
}
