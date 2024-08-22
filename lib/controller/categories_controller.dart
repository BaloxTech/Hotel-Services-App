// ignore_for_file: prefer_final_fields

import 'dart:convert';
import 'package:get/get.dart';
import 'package:hotel_services_app/common/snackbar.dart';
import 'package:hotel_services_app/data/model/response/categories.dart';
import 'package:hotel_services_app/data/repository/category_repo.dart';

class CategoryController extends GetxController implements GetxService {
  final CategoryRepo categoryRepo;
  CategoryController({required this.categoryRepo});

  List<Categories> _categoryList = [];
  List<Categories> _subcategoryList = [];
  bool _isLoading = false;

  List<Categories> get categoryList => _categoryList;
  List<Categories> get subcategoryList => _subcategoryList;
  bool get isLoading => _isLoading;

  Future<void> init({bool reload = false}) async {
    if (_categoryList.isEmpty && _subcategoryList.isEmpty || reload) {
      _isLoading = true;
      update();
      await getCategoryList();
      await getSubCategoryList();
      _isLoading = false;
      update();
    }
  }

  Future<void> getCategoryList() async {
    var response = await categoryRepo.getCategoryList();
    if (response != null) {
      _categoryList = (jsonDecode(response.body) as List)
          .map((e) => Categories.fromJson(e))
          .toList();
      _categoryList.sort((a, b) => a.id!.compareTo(b.id!));
    } else {
      errorMessage();
    }
  }

  Future<void> getSubCategoryList() async {
    var response = await categoryRepo.getSubCategoryList();
    if (response != null) {
      _subcategoryList = (jsonDecode(response.body) as List)
          .map((e) => Categories.fromJson(e))
          .toList();
    } else {
      errorMessage();
    }
  }

  String getCategoryName(int categoryId) {
    String categoryName = '';
    for (int i = 0; i < _categoryList.length; i++) {
      if (_categoryList[i].id == categoryId) {
        categoryName = _categoryList[i].title!;
        break;
      }
    }
    return categoryName;
  }

  static CategoryController get to => Get.find();
}
