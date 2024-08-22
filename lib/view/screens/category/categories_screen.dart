import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/tabbutton.dart';
import '../../../data/model/response/food.dart';
import '../../../utils/icons.dart';
import '../../../utils/images.dart';
import '../../../utils/network_image.dart';

class CategoryScreen extends StatelessWidget {
  final List<FoodModel> food;
  const CategoryScreen({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        backgroundColor: Theme.of(context).disabledColor,
        automaticallyImplyLeading: false,
        title: Image.asset(Images.logo, width: Get.width * 0.5),
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: food.length,
          scrollDirection: Axis.vertical,
          itemBuilder: ((context, index) => SizedBox(
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
                                food[index].title.toString(),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                food[index].description.toString(),
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
                                    color: food[index].rating.toString().isEmpty
                                        ? Colors.orange
                                        : Colors.black26,
                                    size: 15,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    food[index].rating.toString().isNotEmpty
                                        ? ''
                                        : food[index].rating.toString(),
                                    style: const TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  food[index].price.toString(),
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
                                url: food[index].imageUrl,
                                fit: BoxFit.cover,
                              )),
                        )
                      ],
                    ),
                  ),
                ),
              ))),
    );
  }
}
