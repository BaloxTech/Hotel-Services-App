import 'dart:convert';
import 'dart:io';
import 'package:hotel_services_app/data/api/api_client.dart';
import 'package:hotel_services_app/data/model/response/user.dart';
import 'package:hotel_services_app/utils/app_constants.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

String token = '';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.apiClient, required this.sharedPreferences});

  // user exist
  Future<dynamic> isUserExist(String email) async {
    return await apiClient
        .postData(AppConstants.checkEmailURL, {'email': email});
  }

  // get user
  Future<AppUser?> getUser(String email) async {
    var response =
        await apiClient.getData("${AppConstants.getUserURL}?email=$email");
    if (response != null) {
      // log(response.body);
      return AppUser.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  // if user not exist save user
  Future<void> saveUser(Map<String, dynamic> data) async {
    await apiClient.postData(AppConstants.storeUserURL, data);
  }

  // update user
  Future<void> updateUser(Map<String, dynamic> data) async {
    await apiClient.postData(AppConstants.updateUserURL, data);
  }

  // upload user image
  Future<void> uploadUserImage(String email, File file) async {
    await apiClient.postMultipartData(AppConstants.updateUserImage,
        [MultipartBody('image', XFile(file.path))],
        body: {'email': email});
  }
}
