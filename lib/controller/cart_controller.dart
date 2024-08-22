// ignore_for_file: prefer_final_fields

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hotel_services_app/common/snackbar.dart';
import 'package:hotel_services_app/controller/auth_controller.dart';
import 'package:hotel_services_app/controller/food_controller.dart';
import 'package:hotel_services_app/data/model/body/cart.dart';
import 'package:hotel_services_app/data/model/response/addons.dart';
import 'package:hotel_services_app/data/model/response/food.dart';
import 'package:hotel_services_app/data/repository/cart_repo.dart';

import '../helper/navigation.dart';

class CartController extends GetxController implements GetxService {
  final CartRepo cartRepo;
  final FoodController foodController;
  CartController({required this.cartRepo, required this.foodController});

  List<CartItem> _cartList = [];

  List<CartItem> get cartList => _cartList;

  addToCart(CartItem cartItem) {
    _cartList.add(cartItem);
    cartRepo.addToCartList(_cartList);
    pop();
    getSnackBar('Added to cart');
    update();
  }

  removeFromCart(CartItem cartItem) {
    _cartList.remove(cartItem);
    cartRepo.addToCartList(_cartList);
    update();
  }

  addQuantity(CartItem cartItem) {
    cartItem.quantity++;
    cartRepo.addToCartList(_cartList);
    update();
  }

  removeQuantity(CartItem cartItem) {
    if (cartItem.quantity > 1) {
      cartItem.quantity--;
      cartRepo.addToCartList(_cartList);
      update();
    } else {
      removeFromCart(cartItem);
    }
  }

  FoodModel getProductById(int id) {
    return foodController.foodList.firstWhere((element) => element.id == id);
  }

  getCartList() {
    _cartList = cartRepo.getCartList();
    update();
  }

  double getItemPrice() {
    double price = 0;
    for (var item in cartList) {
      FoodModel product = CartController.to.getProductById(item.prodctId);
      price += product.price! * item.quantity;
    }
    return price;
  }

  double getAddonsPrice() {
    double price = 0;
    for (var item in cartList) {
      FoodModel product = CartController.to.getProductById(item.prodctId);
      for (var addonId in item.addonIds!) {
        Addon addon =
            product.addons!.firstWhere((element) => element.id == addonId);
        price += addon.price! * item.quantity;
      }
    }
    return price;
  }

  double getDiscountPrice() {
    double loyaltyAmount = AuthController.to.appUser!.loyaltyAmount ?? 0;
    double price = getItemPrice() + getAddonsPrice();
    if (loyaltyAmount > 0) {
      if (loyaltyAmount > price) {
        loyaltyAmount = price;
      }
    }
    return loyaltyAmount;
  }

  double get getTotal =>
      (getItemPrice() + getAddonsPrice()) - getDiscountPrice();

  placeOrder(bool table, int id) async {
    SmartDialog.showLoading();
    Map<String, dynamic> body = {
      'table': table ? 1 : 0,
      'id': id,
      'cart': cartList.map((e) => e.toJson()).toList(),
      'user_id': AuthController.to.appUser!.id,
      'addons_price': getAddonsPrice(),
      'total': getTotal,
      'discount': getDiscountPrice(),
    };
    var response = await cartRepo.placeOrder(body);
    SmartDialog.dismiss();
    if (response != null && response.statusCode == 200) {
      _cartList.clear();
      cartRepo.addToCartList(_cartList);
      update();
      pop();
      getSnackBar('Order placed successfully');
    }
  }

  static CartController get to => Get.find();
}
