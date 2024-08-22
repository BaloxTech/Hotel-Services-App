import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:hotel_services_app/common/button.dart';
import 'package:hotel_services_app/common/icons.dart';
import 'package:hotel_services_app/common/tabbutton.dart';
import 'package:hotel_services_app/controller/theme_controller.dart';
import 'package:hotel_services_app/data/model/response/room.dart';
import 'package:hotel_services_app/helper/navigation.dart';
import 'package:hotel_services_app/utils/app_constants.dart';
import 'package:hotel_services_app/utils/icons.dart';
import 'package:hotel_services_app/utils/network_image.dart';
import 'package:hotel_services_app/utils/style.dart';
import 'package:hotel_services_app/view/screens/webview/webview.dart';

import 'package:url_launcher/url_launcher_string.dart';

import '../../../utils/images.dart';

class RoomDetailPage extends StatefulWidget {
  final Room room;
  const RoomDetailPage({required this.room, super.key});

  @override
  State<RoomDetailPage> createState() => _RoomDetailPageState();
}

class _RoomDetailPageState extends State<RoomDetailPage> {
  int selectIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Images.background), fit: BoxFit.cover)),
            ),
            SizedBox(
              height: getPixels(context, 250),
              child: Stack(
                children: [
                  PageView.builder(
                      itemCount: widget.room.photos!.isEmpty
                          ? 1
                          : widget.room.photos!.length,
                      onPageChanged: (index) {
                        setState(() {
                          selectIndex = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        return Hero(
                            tag: widget.room.id!,
                            child: CustomNetworkImage(
                                url: widget.room.photos!.isEmpty
                                    ? ''
                                    : widget.room.photos![index]));
                      }),
                  const Positioned(
                    top: 1,
                    left: 0,
                    child: CustomBackButton(),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                height: MediaQuery.of(context).size.height * .63,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    // title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.room.title!,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                  color: const Color(0xff575656),
                                  fontSize: 20,
                                  fontWeight: fontWeightSemiBold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // details

                    // facilities
                    Expanded(
                      child: ListView(
                        children: [
                          const Text(
                            'Details',
                            style: TextStyle(
                                color: Color(0xff575656),
                                fontSize: 16,
                                fontWeight: fontWeightSemiBold),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              _detailsWidget('${widget.room.person} persons',
                                  FFIcons.user),
                              _detailsWidget(
                                  '${widget.room.bed} beds', Icons.bed),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 2),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  '${widget.room.price} $CURRENCY',
                                  style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.room.facilities!.isEmpty
                                  ? const SizedBox()
                                  : const Text(
                                      'Facilities',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: fontWeightSemiBold),
                                    ),
                              const SizedBox(height: 10),
                              for (var item in widget.room.facilities!)
                                _facilitiesWidget(item.name!, item.image!),
                            ],
                          ),
                          // desciption
                          const SizedBox(height: 10),
                          const Text(
                            'Description',
                            style: TextStyle(
                                color: Color(0xff575656),
                                fontSize: 16,
                                fontWeight: fontWeightSemiBold),
                          ),
                          const SizedBox(height: 10),
                          Html(
                            data: widget.room.description,
                            shrinkWrap: true,
                            style: {
                              'body': Style(
                                  fontSize: const FontSize(12),
                                  fontWeight: fontWeightNormal,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  color: isDark
                                      ? Colors.white
                                      : const Color(0xff8A8686),
                                  fontFamily: 'poppins'),
                            },
                            onLinkTap: (url, context, map, element) {
                              launchUrlString(url!);
                            },
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: CustomButton(
                          text: 'Check Availablity',
                          onPressed: () {
                            launchScreen(const LoadWebView(
                                url: 'https://www.leparis.nc/all-rooms/'));
                          }),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _detailsWidget(String text, IconData icon) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIcon(
            icon: icon,
            iconSize: 20,
            padding: 5,
          ),
          const SizedBox(width: 5),
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: const Color(0xff8A8686)),
          ),
        ],
      );

  _facilitiesWidget(String text, String image) => ListTile(
        contentPadding: const EdgeInsets.all(0),
        visualDensity: const VisualDensity(horizontal: -4, vertical: -2),
        leading: Container(
          padding: const EdgeInsets.all(5),
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(30)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: CachedNetworkImage(imageUrl: image),
          ),
        ),
        title: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      );
}
