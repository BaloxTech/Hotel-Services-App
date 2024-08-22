import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hotel_services_app/common/button.dart';
import 'package:hotel_services_app/common/tabbutton.dart';
import 'package:hotel_services_app/controller/theme_controller.dart';
import 'package:hotel_services_app/data/model/response/service.dart';
import 'package:hotel_services_app/utils/app_constants.dart';
import 'package:hotel_services_app/utils/network_image.dart';
import 'package:hotel_services_app/utils/style.dart';

import 'package:url_launcher/url_launcher_string.dart';

class ServiceDetailPage extends StatefulWidget {
  final ServiceModel service;
  const ServiceDetailPage({required this.service, super.key});

  @override
  State<ServiceDetailPage> createState() => _ServiceDetailPageState();
}

class _ServiceDetailPageState extends State<ServiceDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: CustomButton(text: 'Continue', onPressed: () {}),
      ),
      body: Column(
        children: [
          SizedBox(
            height: getPixels(context, 250),
            width: double.infinity,
            child: Stack(
              children: [
                Hero(
                    tag: widget.service.id!,
                    child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: CustomNetworkImage(url: widget.service.image))),

                // back button
                Positioned(
                  top: MediaQuery.of(context).padding.top + 1,
                  left: 0,
                  child: const CustomBackButton(),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            widget.service.title!,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                    fontSize: 20,
                                    fontWeight: fontWeightSemiBold),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${widget.service.price} $CURRENCY',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  fontWeight: fontWeightBold,
                                  color: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),

                    // desciption
                    const SizedBox(height: 20),
                    const Text(
                      'Description',
                      style: TextStyle(
                          fontSize: 16, fontWeight: fontWeightSemiBold),
                    ),
                    Html(
                      data: widget.service.description,
                      shrinkWrap: true,
                      style: {
                        'body': Style(
                            fontSize: const FontSize(12),
                            fontWeight: fontWeightNormal,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            color: isDark ? Colors.white : Colors.black,
                            fontFamily: 'poppins'),
                      },
                      onLinkTap: (url, context, map, element) {
                        launchUrlString(url!);
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
