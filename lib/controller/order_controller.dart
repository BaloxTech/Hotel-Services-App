import 'dart:convert';
import 'package:get/get.dart';
import 'package:hotel_services_app/data/model/response/order.dart';

import '../data/repository/order_repo.dart';

class OrderController extends GetxController implements GetxService {
  final OrderRepo orderRepo;
  OrderController({required this.orderRepo});

  List<OrderModel> _orderList = [];
  List<OrderModel> _activeOrderList = [];
  List<OrderModel> _pastOrderList = [];
  OrderDetailModel? _orderDetails;
  bool _isLoading = true;

  List<OrderModel> get orderList => _orderList;
  List<OrderModel> get activeOrderList => _activeOrderList;
  List<OrderModel> get pastOrderList => _pastOrderList;
  OrderDetailModel? get orderDetails => _orderDetails;
  bool get isLoading => _isLoading;

  getOrderList() async {
    _setLoading(true);
    var response = await orderRepo.getOrders();
    if (response != null && response.statusCode == 200) {
      _orderList = List<OrderModel>.from(
          jsonDecode(response.body).map((e) => OrderModel.fromJson(e)));
      _orderList = _orderList.reversed.toList();
      _activeOrderList = _orderList
          .where((element) =>
              element.status == 'pending' || element.status == 'confirmed')
          .toList();
      _pastOrderList = _orderList
          .where((element) =>
              element.status == 'delivered' || element.status == 'cancelled')
          .toList();
      _setLoading(false);
    }
  }

  getOrderDetails(int id) async {
    _orderDetails = null;
    _setLoading(true);
    var response = await orderRepo.getOrderDetails(id);
    if (response != null && response.statusCode == 200) {
      _orderDetails = OrderDetailModel.fromJson(jsonDecode(response.body));
      _setLoading(false);
    }
  }

  _setLoading(bool value) {
    _isLoading = value;
    update();
  }

  static OrderController get to => Get.find();
}
