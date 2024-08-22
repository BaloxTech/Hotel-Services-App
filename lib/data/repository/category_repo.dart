import 'package:hotel_services_app/data/api/api_client.dart';
import 'package:hotel_services_app/utils/app_constants.dart';
import 'package:http/http.dart';

class CategoryRepo {
  final ApiClient apiClient;
  CategoryRepo({required this.apiClient});

  Future<Response?> getCategoryList() async {
    return await apiClient.getData(AppConstants.getCategoryURL);
  }

  Future<Response?> getSubCategoryList() async {
    return await apiClient.getData(AppConstants.getSubCategoryURL);
  }
}
