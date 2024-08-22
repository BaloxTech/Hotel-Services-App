// ignore_for_file: prefer_final_fields

import 'dart:convert';
import 'package:get/get.dart';
import 'package:hotel_services_app/common/snackbar.dart';
import 'package:hotel_services_app/controller/categories_controller.dart';
import 'package:hotel_services_app/data/model/response/food.dart';
import 'package:hotel_services_app/data/repository/food_repo.dart';

class FoodController extends GetxController implements GetxService {
  final FoodRepo foodRepo;
  FoodController({required this.foodRepo});

  List<FoodModel> _foodList = [];
  List<FoodModel> _filteredList = [];
  int _selectedCategory = 0;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<FoodModel> get foodList => _foodList;
  List<FoodModel> get filteredList => _filteredList;
  int get selectedCategory => _selectedCategory;

  Future<void> init({bool reload = false}) async {
    if (_foodList.isEmpty || reload) {
      _isLoading = true;
      update();
      await getFoodList();
      _isLoading = false;
      update();
    }
  }

  getFoodList() async {
    var response = await foodRepo.getFoodList();
    if (response != null) {
      _foodList = (jsonDecode(response.body) as List)
          .map((e) => FoodModel.fromJson(e))
          .toList();
      _filteredList = _foodList;
      filterByCategory(CategoryController.to.categoryList.first.id!, 0);
    } else {
      errorMessage();
    }
    update();
  }

  searchFood(String query) {
    if (query.isEmpty) {
      _filteredList = _foodList;
    } else {
      _filteredList = _foodList
          .where(
              (food) => food.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    update();
  }

  filterByCategory(int? categoryId, int? index) {
    _filteredList =
        foodList.where((food) => food.category == categoryId).toList();
    selectedCategory = index!;
  }

  set selectedCategory(int index) {
    _selectedCategory = index;
    update();
  }

  static FoodController get to => Get.find();
}
