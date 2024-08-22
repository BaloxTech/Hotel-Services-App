import 'package:hotel_services_app/data/api/api_client.dart';
import 'package:hotel_services_app/utils/app_constants.dart';
import 'package:http/http.dart';

class BannerRepo {
  final ApiClient apiClient;
  BannerRepo({required this.apiClient});

  Future<Response?> getBanners() async =>
      await apiClient.getData(AppConstants.getBannersURL);
}
