import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_services_app/common/icons.dart';
import 'package:hotel_services_app/common/tabbutton.dart';
import 'package:hotel_services_app/controller/cart_controller.dart';
import 'package:hotel_services_app/data/model/body/cart.dart';
import 'package:hotel_services_app/data/model/response/addons.dart';
import 'package:hotel_services_app/data/model/response/food.dart';
import 'package:hotel_services_app/utils/app_constants.dart';
import 'package:hotel_services_app/utils/icons.dart';
import 'package:hotel_services_app/utils/images.dart';
import 'package:hotel_services_app/utils/network_image.dart';
import 'package:hotel_services_app/utils/style.dart';

class FoodDetailPage extends StatefulWidget {
  final FoodModel food;
  const FoodDetailPage({required this.food, super.key});

  @override
  State<FoodDetailPage> createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  int? selectedVariation;
  List<bool> selectedAddons = [];
  int quantity = 1;
  double finalPrice = 0;

  @override
  void initState() {
    if (widget.food.varations!.isNotEmpty) {
      selectedVariation = 0;
    }
    selectedAddons =
        List.generate(widget.food.addons!.length, (index) => false);

    setPrice();
    super.initState();
  }

  addQuantity({bool isAdd = true}) {
    if (isAdd) {
      quantity++;
    } else {
      if (quantity > 1) {
        quantity--;
      }
    }
    setPrice();
  }

  setPrice() {
    double price = 0;
    price += widget.food.price!;
    if (selectedVariation != null) {
      price += widget.food.varations![selectedVariation!].price!;
    }
    for (var addon in selectedAddons) {
      if (addon) {
        price += widget.food.addons![selectedAddons.indexOf(addon)].price!;
      }
    }
    price *= quantity;
    finalPrice = price.toPrecision(2);
    setState(() {});
  }

  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 1,
      width: Get.width * 1,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Images.background), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: const CustomBackButton(),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 110,
              backgroundColor: Colors.transparent,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Hero(
                    tag: widget.food.id!,
                    child: CustomNetworkImage(url: widget.food.imageUrl)),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              height: Get.height * .55,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: Column(children: [
                Text(
                  widget.food.title!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).primaryColor),
                ),
                Text(
                  widget.food.description!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff8A8686)),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      FFIcons.star,
                      color: Colors.orange,
                      size: 50,
                    ),
                    Text(
                      widget.food.rating.toString().isNotEmpty
                          ? '0.0'
                          : widget.food.rating.toString(),
                      style: const TextStyle(fontSize: 10),
                    ),
                  ],
                ),
                Container(
                  height: 50,
                  margin:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(radius),
                  ),
                  child: Row(
                    children: [
                      AnimatedTabButton(
                        text: 'Addons',
                        onTap: () {
                          setState(() {
                            selected = !selected;
                          });
                        },
                        selected: !selected,
                      ),
                      const SizedBox(width: 5),
                      AnimatedTabButton(
                        text: 'Varations',
                        onTap: () {
                          setState(() {
                            selected = !selected;
                          });
                        },
                        selected: selected,
                      ),
                    ],
                  ),
                ),
                selected
                    ? Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.food.addons!.length,
                            itemBuilder: ((context, index) {
                              Addon addon = widget.food.addons![index];
                              return _addonsWidget(addon, index);
                            })),
                      )
                    : Expanded(
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.food.varations!.length,
                            itemBuilder: ((context, index) {
                              Addon variation = widget.food.varations![index];
                              return _variationWidget(variation, index);
                            })),
                      ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Row(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.5,
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(radius)),
                        child: Row(
                          children: [
                            CustomIcon(
                              icon: Icons.remove,
                              iconSize: 18,
                              padding: 5,
                              onTap: () {
                                addQuantity(isAdd: false);
                              },
                            ),
                            const SizedBox(width: 10),
                            Text(
                              '$quantity',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            const SizedBox(width: 10),
                            CustomIcon(
                              icon: Icons.add,
                              iconSize: 18,
                              padding: 5,
                              onTap: () {
                                addQuantity();
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          height: 70,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(radius),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Total',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(color: Colors.white),
                                    ),
                                    Text(
                                      '$finalPrice $CURRENCY',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: _addToCart,
                                child: Wrap(
                                  children: [
                                    Text('Add Item',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(color: Colors.white)),
                                    const SizedBox(width: 5),
                                    Image.asset(
                                      Images.cart,
                                      width: 18,
                                      height: 18,
                                      color: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  _variationWidget(Addon variation, int index) => RadioListTile(
        contentPadding: const EdgeInsets.all(0),
        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
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
                variation.name!.capitalizeFirst!,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '${variation.price} $CURRENCY',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontWeight: fontWeightBold),
            ),
          ],
        ),
        value: index,
        groupValue: selectedVariation,
        onChanged: (value) {
          selectedVariation = value;
          setPrice();
        },
        controlAffinity: ListTileControlAffinity.trailing,
      );

  _addonsWidget(Addon addon, int index) => CheckboxListTile(
        contentPadding: const EdgeInsets.all(0),
        visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
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
                addon.name!,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              '${addon.price} $CURRENCY',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontWeight: fontWeightBold),
            ),
          ],
        ),
        value: selectedAddons[index],
        onChanged: (value) {
          selectedAddons[index] = value!;
          setPrice();
        },
        controlAffinity: ListTileControlAffinity.trailing,
      );

  _addToCart() {
    int? selectedVariationId;
    if (selectedVariation != null) {
      selectedVariationId = widget.food.varations![selectedVariation!].id!;
    }
    List<int> selectedAddonsId = [];
    for (int i = 0; i < selectedAddons.length; i++) {
      if (selectedAddons[i]) {
        selectedAddonsId.add(widget.food.addons![i].id!);
      }
    }
    CartItem cartItem = CartItem(
        prodctId: widget.food.id!,
        quantity: 1,
        variationId: selectedVariationId,
        addonIds: selectedAddonsId,
        total: finalPrice);

    CartController.to.addToCart(cartItem);
  }
}
