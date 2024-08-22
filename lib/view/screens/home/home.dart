import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_services_app/common/textfield.dart';
import 'package:hotel_services_app/controller/auth_controller.dart';
import 'package:hotel_services_app/controller/banner_controller.dart.dart';
import 'package:hotel_services_app/controller/categories_controller.dart';
import 'package:hotel_services_app/controller/food_controller.dart';
import 'package:hotel_services_app/helper/navigation.dart';
import 'package:hotel_services_app/utils/images.dart';
import 'package:hotel_services_app/utils/network_image.dart';
import 'package:hotel_services_app/utils/style.dart';
import 'package:hotel_services_app/view/base/banner.dart';
import 'package:hotel_services_app/view/base/food_view.dart';
import 'package:hotel_services_app/view/screens/search/food_search.dart';

import 'package:shimmer/shimmer.dart';

import '../../base/categories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    initAllData();
    super.initState();
  }

  initAllData({bool reload = false}) async {
    await BannerController.to.getBanners();
    await CategoryController.to.init(reload: reload);
    await FoodController.to.init(reload: reload);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController search = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).disabledColor,
          automaticallyImplyLeading: false,
          title: Image.asset(Images.logo, width: Get.width * 0.5),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(15).copyWith(top: 0),
              child: GetBuilder<AuthController>(builder: (con) {
                return con.appUser != null
                    ? Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: CustomNetworkImage(
                                    url: con.appUser!.image!)),
                          ),
                          const SizedBox(width: 10),
                          Text(con.appUser!.name!,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontWeight: fontWeightNormal)),
                        ],
                      )
                    : Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(50)),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 100,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  width: 150,
                                  height: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
              }),
            ),
            GetBuilder<CategoryController>(builder: (categoryController) {
              return GetBuilder<FoodController>(builder: (foodController) {
                return Expanded(
                    flex: 1,
                    child: RefreshIndicator(
                      onRefresh: () async {
                        initAllData(reload: true);
                      },
                      child: ListView(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: CustomTextField(
                              fillColor: Theme.of(context).disabledColor,
                              boderRadius: 5,
                              padding: EdgeInsets.zero,
                              controller: search,
                              hintText: 'Search for food',
                              readOnly: true,
                              prefixIcon: const Icon(Icons.search_rounded),
                              onTap: () {
                                launchScreen(const FoodSearch());
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          const BannerView(),
                          CategoryView(
                              categories: categoryController.categoryList),
                          if (categoryController.isLoading ||
                              foodController.isLoading) ...[
                            for (var i = 0; i < 3; i++) ...[
                              const FoodViewShimmer(),
                              const SizedBox(height: 5),
                            ]
                          ] else ...[
                            for (var item in CategoryController.to.categoryList)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: FoodViewHorizontal(
                                    title: categoryController
                                        .getCategoryName(item.id!),
                                    foods: FoodController.to.foodList
                                        .where(
                                            (food) => food.category == item.id)
                                        .toList()),
                              ),
                          ],
                        ],
                      ),
                    ));
              });
            })
          ],
        ));
  }
}
