// ignore_for_file: prefer_final_fields

import 'dart:convert';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hotel_services_app/common/snackbar.dart';
import 'package:hotel_services_app/controller/auth_controller.dart';
import 'package:hotel_services_app/data/model/response/service.dart';
import 'package:hotel_services_app/data/repository/service_repo.dart';

class ServiceController extends GetxController implements GetxService {
  final ServiceRepo serviceRepo;
  ServiceController({required this.serviceRepo});

  List<ServiceModel> _serviceList = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<ServiceModel> get serviceList => _serviceList;

  Future<void> init({bool reload = false}) async {
    if (_serviceList.isEmpty || reload) {
      _isLoading = true;
      update();
      await getServiceList();
      _isLoading = false;
      update();
    }
  }

  getServiceList() async {
    var response = await serviceRepo.getServiceList();
    if (response != null) {
      _serviceList = (jsonDecode(response.body) as List)
          .map((e) => ServiceModel.fromJson(e))
          .toList();
    } else {
      errorMessage();
    }
    update();
  }

  Future<void> bookService(int service, String room, String description) async {
    SmartDialog.showLoading();
    Map<String, dynamic> body = {
      'frontuser_id': AuthController.to.appUser!.id,
      'service_id': service,
      'room_no': room,
      'description': description
    };
    var response = await serviceRepo.bookService(body);
    SmartDialog.dismiss();
    if (response != null) {
      getSnackBar('Service booked successfully');
    }
  }

  static ServiceController get to => Get.find();
}
