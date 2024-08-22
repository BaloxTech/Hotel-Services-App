import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_services_app/common/seperator.dart';
import 'package:hotel_services_app/common/tabbutton.dart';
import 'package:hotel_services_app/controller/order_controller.dart';
import 'package:hotel_services_app/data/model/response/addons.dart';
import 'package:hotel_services_app/data/model/response/order.dart';
import 'package:hotel_services_app/helper/date.dart';
import 'package:hotel_services_app/utils/app_constants.dart';
import 'package:hotel_services_app/utils/network_image.dart';
import 'package:hotel_services_app/utils/style.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text('Order Details'),
      ),
      body: GetBuilder<OrderController>(builder: (con) {
        return con.isLoading
            ? const Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(),
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(15),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // order id, date, status
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Order ID: ${con.orderDetails!.id}',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            '${con.orderDetails!.status!.capitalizeFirst}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(color: _getColor(con.orderDetails!)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              getDate(con.orderDetails!.createdAt!),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Item(s): ${con.orderDetails!.cartItems!.length}',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      const Divider(),
                      const SizedBox(height: 10),
                      Text(
                        'Order Items',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      for (int i = 0;
                          i < con.orderDetails!.cartItems!.length;
                          i++) ...[
                        Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          padding: const EdgeInsets.all(5),
                          width: double.infinity,
                          child: Row(
                            children: [
                              SizedBox(
                                width: 75,
                                height: 75,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(radius),
                                  child: CustomNetworkImage(
                                      url: con.orderDetails!.cartItems![i].food
                                              .imageUrl ??
                                          ''),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(con.orderDetails!
                                                  .cartItems![i].food.title ??
                                              ''),
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                            '${con.orderDetails!.cartItems![i].food.price ?? ''} $CURRENCY'),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      'Quantity: ${con.orderDetails!.cartItems![i].quantity}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                    ),
                                    const SizedBox(height: 5),
                                    if (con.orderDetails!.cartItems![i]
                                            .variationId !=
                                        null)
                                      Text(
                                        "Variation: ${con.orderDetails!.cartItems![i].food.varations!.firstWhere((element) => element.id == con.orderDetails!.cartItems![i].variationId).name!}",
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                    const SizedBox(height: 5),
                                    if (con.orderDetails!.cartItems![i]
                                                .addonIds !=
                                            null &&
                                        con.orderDetails!.cartItems![i]
                                            .addonIds!.isNotEmpty)
                                      Text(
                                        getAddonsText(
                                            con.orderDetails!.cartItems![i]),
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (i != con.orderDetails!.cartItems!.length - 1)
                          const Divider(),
                      ],
                      const SizedBox(height: 10),
                      const MySeparator(),
                      const SizedBox(height: 15),
                      _priceWidget('Items Price',
                          '${con.orderDetails!.amount! - getAddonsPrice(con.orderDetails!)} $CURRENCY'),

                      const SizedBox(height: 5),
                      _priceWidget('Addons Price',
                          '${getAddonsPrice(con.orderDetails!)} $CURRENCY'),

                      const SizedBox(height: 15),
                      const MySeparator(),
                      const SizedBox(height: 15),
                      _priceWidget('Total Bill',
                          '${con.orderDetails!.amount!} $CURRENCY'),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              );
      }),
    );
  }

  _priceWidget(String title, String price) => Row(
        children: [
          Text(
            title,
          ),
          const Spacer(),
          Text(
            price,
            style: const TextStyle(fontWeight: fontWeightNormal),
          ),
        ],
      );

  double getAddonsPrice(OrderDetailModel order) {
    double addonsPrice = 0;
    for (var item in order.cartItems!) {
      if (item.addonIds != null && item.addonIds!.isNotEmpty) {
        for (int i = 0; i < item.addonIds!.length; i++) {
          Addon addon = item.food.addons!
              .firstWhere((element) => element.id == item.addonIds![i]);
          addonsPrice += addon.price!;
        }
      }
    }
    return addonsPrice;
  }

  getAddonsText(CartItem item) {
    String addonsText = '';
    for (int i = 0; i < item.addonIds!.length; i++) {
      Addon addon = item.food.addons!
          .firstWhere((element) => element.id == item.addonIds![i]);
      if (i == item.addonIds!.length - 1) {
        addonsText += '${addon.name}';
      } else {
        addonsText += '${addon.name}, ';
      }
    }
    return addonsText;
  }

  _getColor(OrderDetailModel order) => order.status == 'pending'
      ? const Color(0xFFE3C493)
      : order.status == 'cancelled'
          ? Theme.of(context).colorScheme.error
          : order.status == 'confirmed'
              ? Theme.of(context).primaryColor
              : Colors.green;
}
