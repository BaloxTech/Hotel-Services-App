import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_services_app/controller/rooms_controller.dart';
import 'package:hotel_services_app/data/model/response/room.dart';
import 'package:hotel_services_app/helper/navigation.dart';
import 'package:hotel_services_app/utils/app_constants.dart';
import 'package:hotel_services_app/utils/network_image.dart';
import 'package:hotel_services_app/utils/style.dart';
import 'package:hotel_services_app/view/screens/rooms/room_detail_page.dart';

class RoomView extends StatelessWidget {
  const RoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RoomsController>(builder: (con) {
      return con.isLoading
          ? ListView.builder(
              itemCount: 6,
              padding: const EdgeInsets.only(top: 15),
              itemBuilder: (context, index) {
                return const RommWidgetShimmer();
              })
          : ListView.builder(
              itemCount: con.roomList.length,
              padding: const EdgeInsets.only(top: 15),
              itemBuilder: (context, index) {
                return RoomWidget(
                    room: con.roomList[index], favourite: index.isOdd);
              });
    });
  }
}

class RoomWidget extends StatelessWidget {
  final Room room;
  final bool favourite;
  const RoomWidget({required this.room, required this.favourite, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width * 1,
      height: Get.height * .25,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: InkWell(
        onTap: () {
          launchScreen(RoomDetailPage(room: room));
        },
        child: Column(
          children: [
            Card(
              elevation: 8,
              shadowColor: Theme.of(context).primaryColor,
              margin: EdgeInsets.zero,
              child: SizedBox(
                width: Get.width * 1,
                height: Get.height * .15,
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(radius),
                        topRight: Radius.circular(radius)),
                    child: Hero(
                        tag: room.id!,
                        child: CustomNetworkImage(
                            url: room.photos!.isEmpty
                                ? ''
                                : room.photos!.first))),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            room.title!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Color(0xff575656),
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            // price
                            '${room.price} $CURRENCY',
                            style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    // const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${room.person} person, ${room.bed} bed',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12, color: Color(0xff8A8686)),
                        ),
                        const Text(
                          'Per Night',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style:
                              TextStyle(fontSize: 12, color: Color(0xff8A8686)),
                        ),
                      ],
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

  String facilities() {
    String facilities = '';
    for (var i = 0; i < room.facilities!.length; i++) {
      facilities += room.facilities![i].name!;
      if (i < room.facilities!.length - 1) {
        facilities += ', ';
      }
    }
    return facilities;
  }
}

class RommWidgetShimmer extends StatelessWidget {
  const RommWidgetShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Row(
        children: [
          Container(
            width: Get.width / 3,
            height: Get.height * .25,
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width / 2,
                  height: 20,
                  color: Theme.of(context).cardColor,
                ),
                const SizedBox(height: 5),
                Container(
                  width: Get.width / 2,
                  height: 20,
                  color: Theme.of(context).cardColor,
                ),
                const SizedBox(height: 5),
                Container(
                  width: Get.width / 2,
                  height: 20,
                  color: Theme.of(context).cardColor,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
