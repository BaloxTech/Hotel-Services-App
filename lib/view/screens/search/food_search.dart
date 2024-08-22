import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:hotel_services_app/common/tabbutton.dart';
import 'package:hotel_services_app/common/textfield.dart';
import 'package:hotel_services_app/controller/food_controller.dart';
import 'package:hotel_services_app/data/model/response/food.dart';
import 'package:hotel_services_app/view/base/food_view.dart';

class FoodSearch extends StatefulWidget {
  const FoodSearch({super.key});

  @override
  State<FoodSearch> createState() => _FoodSearchState();
}

class _FoodSearchState extends State<FoodSearch> {
  TextEditingController search = TextEditingController();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      FoodController.to.searchFood('');
    });
    super.initState();
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text('Search Food'),
      ),
      body: GetBuilder<FoodController>(builder: (foodCon) {
        return Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              CustomTextField(
                fillColor: Theme.of(context).disabledColor,
                boderRadius: 5,
                padding: EdgeInsets.zero,
                controller: search,
                hintText: 'Search for food',
                prefixIcon: const Icon(Icons.search_rounded),
                onChanged: (query) {
                  foodCon.searchFood(query);
                },
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: foodCon.filteredList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio: 1.05),
                    itemBuilder: (context, index) {
                      FoodModel food = foodCon.filteredList[index];
                      return FoodWidgetHorizontal(
                        food: food,
                        isLast: true,
                        search: true,
                      );
                    }),
              )
            ],
          ),
        );
      }),
    );
  }
}
