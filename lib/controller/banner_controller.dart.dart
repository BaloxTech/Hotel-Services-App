import 'dart:convert';

import 'package:get/get.dart';

import '../common/snackbar.dart';
import '../data/model/response/banner.dart';
import '../data/repository/banner_repo.dart';

class BannerController extends GetxController implements GetxService {
  final BannerRepo bannerRepo;
  BannerController({required this.bannerRepo});

  List<Banners> _banners = [];
  bool _loading = true;

  List<Banners> get banners => _banners;
  bool get loading => _loading;

  getBanners() async {
    _loading = true;
    update();
    var response = await bannerRepo.getBanners();
    if (response != null) {
      // log(response.body.toString());
      _banners = (jsonDecode(response.body) as List)
          .map((e) => Banners.fromJson(e))
          .toList();
      _loading = false;
      update();
    } else {
      errorMessage();
    }
    update();
  }

  static BannerController get to => Get.find();
}
