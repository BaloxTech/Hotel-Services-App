import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_services_app/controller/order_controller.dart';
import 'package:hotel_services_app/data/model/response/order.dart';
import 'package:hotel_services_app/helper/date.dart';
import 'package:hotel_services_app/helper/navigation.dart';
import 'package:hotel_services_app/utils/app_constants.dart';
import 'package:hotel_services_app/utils/style.dart';
import 'package:hotel_services_app/view/screens/order/order_details.dart';

class OrderWidget extends StatelessWidget {
  final OrderModel order;
  const OrderWidget({required this.order, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Text(getDate(order.createdAt!)),
            const Spacer(),
            Text(order.status!.capitalizeFirst!,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: _getColor(context), fontWeight: fontWeightNormal)),
          ],
        ),
        GestureDetector(
          onTap: () {
            OrderController.to.getOrderDetails(order.id!);
            launchScreen(const OrderDetails());
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(radius),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order ID: #${order.id}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 5),
                          Text('Item(s): ${order.cartLength!}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontWeight: fontWeightNormal)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('${order.amount} $CURRENCY',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: fontSizeLarge(context))),
                        Text('Total',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Theme.of(context).hintColor)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 30)
      ],
    );
  }

  _getColor(BuildContext context) => order.status == 'pending'
      ? const Color(0xFFE3C493)
      : order.status == 'cancelled'
          ? Theme.of(context).colorScheme.error
          : order.status == 'confirmed'
              ? Theme.of(context).primaryColor
              : Colors.green;
}

class OrderWidgetShimmer extends StatelessWidget {
  const OrderWidgetShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Container(
              height: 20,
              width: 100,
              color: Theme.of(context).cardColor,
            ),
            const Spacer(),
            Container(
              height: 20,
              width: 100,
              color: Theme.of(context).cardColor,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(10),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 20,
                          width: 100,
                          color: Theme.of(context).cardColor,
                        ),
                        const SizedBox(height: 5),
                        Container(
                          height: 20,
                          width: 100,
                          color: Theme.of(context).cardColor,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 20,
                        width: 100,
                        color: Theme.of(context).cardColor,
                      ),
                      const SizedBox(height: 5),
                      Container(
                        height: 20,
                        width: 100,
                        color: Theme.of(context).cardColor,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                height: 20,
                width: 100,
                color: Theme.of(context).cardColor,
              ),
              const SizedBox(height: 10),
              Container(
                height: 20,
                width: 100,
                color: Theme.of(context).cardColor,
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
        const SizedBox(height: 30)
      ],
    );
  }
}
