// ignore_for_file: constant_identifier_names

import 'package:hotel_services_app/data/model/body/language.dart';

import 'images.dart';

const String CURRENCY = 'F';

class AppConstants {
  static const String APP_NAME = 'Hotel Le Paris';

  // API's
  static const String domain = 'https://hotel.dcodax.net';
  static const String baseURL = '$domain/api/frontend';
  static const String checkEmailURL = '$baseURL/check_email';
  static const String getUserURL = '$baseURL/users/get';
  static const String storeUserURL = '$baseURL/users/store';
  static const String updateUserURL = '$baseURL/users/update-user';
  static const String updateUserImage = '$baseURL/users/update-image';
  static const String getBannersURL = '$baseURL/banner/get';

  // category
  static const String getCategoryURL = '$baseURL/category/get';
  static String getSubCategoryURL = '$baseURL/sub-category/get';

  // food
  static String getFoodListURL = '$baseURL/item/get';

  // room
  static String getRoomListURL = '$baseURL/room/get';

  // service
  static String getServiceListURL = '$baseURL/service/get';
  static String bookServiceURL = '$baseURL/service/book-service';

  // order
  static String placeOrder = '$baseURL/order/place-order';
  static String getOrderList = '$baseURL/order/get';
  static String getOrderDetails = '$baseURL/order/details';

  // Shared Key
  static const String THEME = 'theme';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String CART_LIST = 'cart_list';

  // Language
  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.english,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en'),
    LanguageModel(
        imageUrl: Images.spanish,
        languageName: 'Spanish',
        countryCode: 'ES',
        languageCode: 'es'),
  ];
}
