import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_services_app/utils/images.dart';
import 'package:hotel_services_app/utils/style.dart';

class EmptyOrderWidget extends StatelessWidget {
  const EmptyOrderWidget({super.key});

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
          const Text('No Orders', style: TextStyle(fontSize: 24)),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
            child: const Text(
              'Looks like you haven\'t ordered anything yet',
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: fontWeightNormal),
            ),
          ),
        ],
      ),
    );
  }
}
