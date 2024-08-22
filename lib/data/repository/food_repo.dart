import 'package:hotel_services_app/data/api/api_client.dart';
import 'package:hotel_services_app/utils/app_constants.dart';
import 'package:http/http.dart';

class FoodRepo {
  final ApiClient apiClient;
  FoodRepo({required this.apiClient});

  Future<Response?> getFoodList() async {
    return await apiClient.getData(AppConstants.getFoodListURL);
  }
}
