import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hotel_services_app/controller/auth_controller.dart';
import 'package:hotel_services_app/controller/cart_controller.dart';
import 'package:hotel_services_app/controller/categories_controller.dart';
import 'package:hotel_services_app/controller/food_controller.dart';
import 'package:hotel_services_app/controller/localization_controller.dart';
import 'package:hotel_services_app/controller/order_controller.dart';
import 'package:hotel_services_app/controller/rooms_controller.dart';
import 'package:hotel_services_app/controller/service_controller.dart';
import 'package:hotel_services_app/controller/theme_controller.dart';
import 'package:hotel_services_app/data/api/api_client.dart';
import 'package:hotel_services_app/data/model/body/language.dart';
import 'package:hotel_services_app/data/repository/auth_repo.dart';
import 'package:hotel_services_app/data/repository/banner_repo.dart';
import 'package:hotel_services_app/data/repository/cart_repo.dart';
import 'package:hotel_services_app/data/repository/category_repo.dart';
import 'package:hotel_services_app/data/repository/food_repo.dart';
import 'package:hotel_services_app/data/repository/language_repo.dart';
import 'package:hotel_services_app/data/repository/order_repo.dart';
import 'package:hotel_services_app/data/repository/room_repo.dart';
import 'package:hotel_services_app/data/repository/service_repo.dart';
import 'package:hotel_services_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../controller/banner_controller.dart.dart';

Future<Map<String, Map<String, String>>> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient());

  // Repository
  Get.lazyPut(() => LanguageRepo());
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => CategoryRepo(apiClient: Get.find()));
  Get.lazyPut(() => FoodRepo(apiClient: Get.find()));
  Get.lazyPut(() => RoomRepo(apiClient: Get.find()));
  Get.lazyPut(() => ServiceRepo(apiClient: Get.find()));
  Get.lazyPut(
      () => CartRepo(sharedPreferences: Get.find(), apiClient: Get.find()));
  Get.lazyPut(() => OrderRepo(apiClient: Get.find()));
  Get.lazyPut(() => BannerRepo(apiClient: Get.find()));

  // Controller
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find()));
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => CategoryController(categoryRepo: Get.find()));
  Get.lazyPut(() => FoodController(foodRepo: Get.find()));
  Get.lazyPut(() => RoomsController(roomRepo: Get.find()));
  Get.lazyPut(() => ServiceController(serviceRepo: Get.find()));
  Get.lazyPut(
      () => CartController(cartRepo: Get.find(), foodController: Get.find()));
  Get.lazyPut(() => OrderController(orderRepo: Get.find()));
  Get.lazyPut(() => BannerController(bannerRepo: Get.find()));

  // Retrieving localized data
  Map<String, Map<String, String>> languages = {};
  for (LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues = await rootBundle
        .loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = jsonDecode(jsonStringValues);
    Map<String, String> json = {};
    mappedJson.forEach((key, value) {
      json[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] =
        json;
  }
  return languages;
}
