import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_services_app/common/tabbutton.dart';
import 'package:hotel_services_app/controller/order_controller.dart';
import 'package:hotel_services_app/data/model/response/order.dart';
import 'package:hotel_services_app/view/base/empty_orders.dart';
import 'package:hotel_services_app/view/base/order_widget.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  int _selectedIndex = 0;

  @override
  void initState() {
    OrderController.to.getOrderList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text('Order History'),
      ),
      body: GetBuilder<OrderController>(builder: (con) {
        return Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Row(
                    children: [
                      AnimatedTabButton(
                        text: 'Active Orders',
                        selected: _selectedIndex == 0,
                        onTap: () {
                          setState(() {
                            _selectedIndex = 0;
                          });
                        },
                      ),
                      const SizedBox(width: 10),
                      AnimatedTabButton(
                        text: 'Past Orders',
                        selected: _selectedIndex == 1,
                        onTap: () {
                          setState(() {
                            _selectedIndex = 1;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                  child: con.isLoading
                      ? ListView.builder(
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return const OrderWidgetShimmer();
                          })
                      : _selectedIndex == 0 && con.activeOrderList.isEmpty
                          ? const EmptyOrderWidget()
                          : _selectedIndex == 1 && con.pastOrderList.isEmpty
                              ? const EmptyOrderWidget()
                              : ListView.builder(
                                  itemCount: _selectedIndex == 0
                                      ? con.activeOrderList.length
                                      : con.pastOrderList.length,
                                  itemBuilder: (context, index) {
                                    OrderModel order = _selectedIndex == 0
                                        ? con.activeOrderList[index]
                                        : con.pastOrderList[index];
                                    return OrderWidget(order: order);
                                  }))
            ],
          ),
        );
      }),
    );
  }
}
