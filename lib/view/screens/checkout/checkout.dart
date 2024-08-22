import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_services_app/common/button.dart';
import 'package:hotel_services_app/common/tabbutton.dart';
import 'package:hotel_services_app/common/textfield.dart';
import 'package:hotel_services_app/controller/cart_controller.dart';
import 'package:hotel_services_app/utils/app_constants.dart';
import 'package:hotel_services_app/utils/style.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int delivery = 0;
  TextEditingController address = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text('Checkout'),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15)
            .copyWith(bottom: GetPlatform.isAndroid ? 15 : 30),
        child: CustomButton(
          text: 'Place Order',
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              CartController.to.placeOrder(
                  delivery == 1, int.parse(address.text.toString()));
            }
          },
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: GetBuilder<CartController>(builder: (con) {
          return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // delivery
                Text(
                  'Delivery',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 5),
                RadioListTile(
                  contentPadding: const EdgeInsets.all(0),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  title: Row(
                    children: [
                      // bullet point
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(5)),
                        child: Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Room Delivery',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                  value: 0,
                  groupValue: delivery,
                  onChanged: (value) {
                    setState(() {
                      delivery = value!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.trailing,
                ),
                RadioListTile(
                  contentPadding: const EdgeInsets.all(0),
                  visualDensity:
                      const VisualDensity(horizontal: 0, vertical: -4),
                  title: Row(
                    children: [
                      // bullet point
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(5)),
                        child: Container(
                          height: 8,
                          width: 8,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Table Delivery',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                  value: 1,
                  groupValue: delivery,
                  onChanged: (value) {
                    setState(() {
                      delivery = value!;
                    });
                  },
                  controlAffinity: ListTileControlAffinity.trailing,
                ),
                CustomTextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(signed: true),
                  hintText:
                      delivery == 0 ? 'Enter room no.' : 'Enter table no.',
                  labelText: delivery == 0 ? 'Room no.' : 'Table no.',
                  controller: address,
                  black: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter ${delivery == 0 ? 'room' : 'table'} no.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                // payment
                Text(
                  'Payment',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 5),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(radius),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Subtotal'),
                          Text('${con.getItemPrice()} $CURRENCY'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Addons'),
                          Text('${con.getAddonsPrice()} $CURRENCY'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Discount'),
                          Text('${con.getDiscountPrice()} $CURRENCY'),
                        ],
                      ),
                      const SizedBox(height: 5),
                      // dotted line
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        height: 1,
                        color: Theme.of(context).dividerColor,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total'),
                          Text('${con.getTotal.toStringAsFixed(1)} $CURRENCY'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      )),
    );
  }
}
