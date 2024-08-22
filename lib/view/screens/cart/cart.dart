import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_services_app/common/button.dart';
import 'package:hotel_services_app/common/icons.dart';
import 'package:hotel_services_app/controller/cart_controller.dart';
import 'package:hotel_services_app/data/model/body/cart.dart';
import 'package:hotel_services_app/data/model/response/addons.dart';
import 'package:hotel_services_app/data/model/response/food.dart';
import 'package:hotel_services_app/helper/navigation.dart';
import 'package:hotel_services_app/utils/app_constants.dart';
import 'package:hotel_services_app/utils/network_image.dart';
import 'package:hotel_services_app/utils/style.dart';
import 'package:hotel_services_app/view/base/empty_cart.dart';
import 'package:hotel_services_app/view/screens/checkout/checkout.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (con) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('My Cart'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        bottomNavigationBar: con.cartList.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(15),
                child: CustomButton(
                    text: 'Checkout',
                    onPressed: () {
                      launchScreen(const CheckoutScreen());
                    }),
              )
            : null,
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: con.cartList.isEmpty
              ? const EmptyCartWidget()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                          itemCount: con.cartList.length,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            CartItem item = con.cartList[index];
                            return _cartProductWidget(context, item);
                          }),
                      const SizedBox(height: 10),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 15),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(radius),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Subtotal'),
                                Text('${con.getItemPrice()} $CURRENCY'),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Addons'),
                                Text('${con.getAddonsPrice()} $CURRENCY'),
                              ],
                            ),
                            const SizedBox(height: 5),
                            // dotted line
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              height: 1,
                              color: Theme.of(context).dividerColor,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Total'),
                                Text(
                                    '${con.getItemPrice() + con.getAddonsPrice()} $CURRENCY'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        )),
      );
    });
  }

  _cartProductWidget(BuildContext context, CartItem item) {
    FoodModel product = CartController.to.getProductById(item.prodctId);
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
            ),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: CustomNetworkImage(url: product.imageUrl)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.title!),
                const SizedBox(height: 5),
                if (item.addonIds != null && item.addonIds!.isNotEmpty) ...[
                  Text(addons(item, product),
                      style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: fontWeightNormal)),
                  const SizedBox(height: 5)
                ],
                Text('${product.price!} $CURRENCY'),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              CustomIcon(
                border: 5,
                icon: Icons.add,
                color: Theme.of(context).primaryColor,
                onTap: () {
                  CartController.to.addQuantity(item);
                },
              ),
              const SizedBox(height: 5),
              Text(item.quantity.toString()),
              const SizedBox(height: 5),
              CustomIcon(
                border: 5,
                icon: Icons.remove,
                color: Theme.of(context).primaryColor,
                onTap: () {
                  CartController.to.removeQuantity(item);
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  String addons(CartItem item, FoodModel product) {
    String addons = '';
    for (int i = 0; i < item.addonIds!.length; i++) {
      Addon addOn = product.addons!
          .firstWhere((element) => element.id == item.addonIds![i]);
      addons += '${addOn.name!}, ';
    }
    return addons;
  }
}
