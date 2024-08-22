import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_services_app/data/model/response/categories.dart';
import 'package:hotel_services_app/helper/navigation.dart';

import 'package:shimmer/shimmer.dart';

import '../../controller/food_controller.dart';
import '../../utils/network_image.dart';
import '../../utils/style.dart';
import '../screens/category/categories_screen.dart';

class CategoryView extends StatelessWidget {
  final List<Categories> categories;
  const CategoryView({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          SizedBox(
            height: Get.height * .12,
            child: ListView.builder(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      FoodController.to
                          .filterByCategory(categories[index].id, index);
                      launchScreen(
                          CategoryScreen(food: FoodController.to.filteredList));
                      log(index.toString());
                    },
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        width: Get.width * .3,
                        margin: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Theme.of(context).primaryColor),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              radius: Get.height * .025,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: CustomNetworkImage(
                                      url: categories[index].image)),
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              categories[index].title.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ],
                        )),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: Get.width * .3,
        // height: Get.height * .12,
        child: Padding(
          padding: const EdgeInsets.only(right: 15),
          child: Container(
            width: Get.width / 2.6,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(radius)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width / 2.6,
                  height: Get.width / 3.7,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(radius),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(radius),
                      child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            color: Colors.grey[300],
                          ))),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 15,
                        color: Colors.grey[300],
                      ),
                    ),
                    const SizedBox(width: 5),
                    Container(
                      height: 15,
                      width: 50,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Container(
                      height: 15,
                      width: 50,
                      color: Colors.grey[300],
                    ),
                    const Spacer(),
                    Container(
                      height: 15,
                      width: 15,
                      color: Colors.grey[300],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
