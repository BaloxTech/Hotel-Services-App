import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_services_app/utils/images.dart';
import 'package:hotel_services_app/utils/style.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Images.emptyCart,
          ),
          const SizedBox(height: 30),
          const Text('Your cart is empty', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
            child: const Text(
              'Looks like you haven\'t added anything to your cart yet',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: fontWeightNormal),
            ),
          ),
        ],
      ),
    );
  }
}
