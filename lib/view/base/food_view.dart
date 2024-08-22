import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_services_app/data/model/response/food.dart';
import 'package:hotel_services_app/helper/navigation.dart';
import 'package:hotel_services_app/utils/icons.dart';
import 'package:hotel_services_app/utils/images.dart';
import 'package:hotel_services_app/utils/network_image.dart';
import 'package:hotel_services_app/utils/style.dart';
import 'package:hotel_services_app/view/screens/home/food_detail_page.dart';

import 'package:shimmer/shimmer.dart';

class FoodViewHorizontal extends StatelessWidget {
  final String title;
  final bool food;
  final List<FoodModel> foods;
  const FoodViewHorizontal(
      {required this.title, required this.foods, this.food = true, super.key});

  @override
  Widget build(BuildContext context) {
    return foods.isEmpty
        ? const SizedBox()
        : Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: Get.height * .25,
                  // Get.width / (food ? 2.35 : 2.4),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: foods.length,
                      itemBuilder: (context, index) {
                        return FoodWidgetHorizontal(
                            food: foods[index],
                            isLast: index == foods.length - 1);
                      }),
                ),
              ],
            ),
          );
  }
}

class FoodWidgetVertical extends StatelessWidget {
  final FoodModel food;
  const FoodWidgetVertical({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height * .2,
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food.title.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w700),
                    ),
                    Text(
                      food.description.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          color: Colors.black45,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Icon(
                          FFIcons.star,
                          color: food.rating.toString().isEmpty
                              ? Colors.orange
                              : Colors.black26,
                          size: 15,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          food.rating.toString().isNotEmpty
                              ? ''
                              : food.rating.toString(),
                          style: const TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        food.price.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * .2,
                width: Get.width * .4,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CustomNetworkImage(
                      url: food.imageUrl,
                      fit: BoxFit.cover,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FoodWidgetHorizontal extends StatelessWidget {
  final FoodModel food;
  final bool isLast;
  final bool search;
  const FoodWidgetHorizontal(
      {required this.food,
      this.isLast = false,
      this.search = false,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: isLast ? 0 : 15),
      child: GestureDetector(
        onTap: () {
          launchScreen(FoodDetailPage(food: food));
        },
        child: Container(
            width: Get.width * .8,
            // padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(5)),
            child: Stack(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(5),
                            topLeft: Radius.circular(5)),
                      ),
                      height: double.infinity,
                      width: 50,
                    ),
                    Container(
                      padding: const EdgeInsets.only(top: 30, bottom: 20),
                      width: Get.width * .35,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            food.title.toString(),
                            maxLines: 3,
                            style: TextStyle(
                                height: 1,
                                fontSize: 16,
                                color: Theme.of(context).primaryColor),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            food.description.toString(),
                            maxLines: 3,
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                              height: 1,
                              fontSize: 12,
                            ),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              Icon(
                                FFIcons.star,
                                color: food.rating.toString().isEmpty
                                    ? Colors.orange
                                    : Colors.black26,
                                size: 15,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                food.rating.toString().isNotEmpty
                                    ? ''
                                    : food.rating.toString(),
                                style: const TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              food.price.toString(),
                              style: const TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: Get.height * .09,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: CustomNetworkImage(url: food.imageUrl)),
                      ),
                    ],
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

// food view shimmer
class FoodViewShimmer extends StatelessWidget {
  const FoodViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(Images.medal),
              const SizedBox(width: 5),
              Container(
                height: 15,
                width: 150,
                color: Colors.grey[300],
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: Get.width / 2.35,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const FoodWidgetShimmer();
                }),
          ),
        ],
      ),
    );
  }
}

class FoodWidgetShimmer extends StatelessWidget {
  const FoodWidgetShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
