import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_services_app/controller/banner_controller.dart.dart';
import 'package:hotel_services_app/helper/navigation.dart';
import 'package:hotel_services_app/utils/style.dart';
import 'package:hotel_services_app/view/screens/home/food_detail_page.dart';

class BannerView extends StatefulWidget {
  const BannerView({super.key});

  @override
  State<BannerView> createState() => _BannerViewState();
}

class _BannerViewState extends State<BannerView> {
  //  int _selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BannerController>(builder: (con) {
      return con.loading
          ? const BannerShimmer()
          : Column(
              children: [
                SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: PageView.builder(
                      onPageChanged: (index) {
                        // setState(() {
                        //   _selectIndex = index;
                        // });
                      },
                      itemCount: con.banners.length,
                      itemBuilder: (context, index) {
                        return _buildImage(con.banners[index].image!, () {
                          if (con.banners[index].item != null) {
                            launchScreen(
                                FoodDetailPage(food: con.banners[index].item!));
                          }
                        });
                      }),
                ),
              ],
            );
    });
  }

  Widget _buildImage(String url, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: 170,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(radius),
          ),
          child: ClipRRect(
            // borderRadius: BorderRadius.circular(radius),
            child: CachedNetworkImage(imageUrl: url, fit: BoxFit.cover),
          )),
    );
  }
}

// banner shimmer
class BannerShimmer extends StatelessWidget {
  const BannerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 170,
          width: double.infinity,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Container(
                    margin: const EdgeInsets.only(right: 10),
                    height: 170,
                    width: 300,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(radius),
                    ));
              }),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (var i = 0; i < 5; i++)
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 7,
                  width: 7,
                  decoration: BoxDecoration(
                      color: i == 0 ? Theme.of(context).primaryColor : null,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                          color: i == 0
                              ? Theme.of(context).primaryColor
                              : Colors.grey)),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
