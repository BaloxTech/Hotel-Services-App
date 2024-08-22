import 'package:flutter/material.dart';
import 'package:hotel_services_app/controller/rooms_controller.dart';
import 'package:hotel_services_app/view/base/rooms_view.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  @override
  void initState() {
    initAllData();
    super.initState();
  }

  initAllData({bool reload = false}) async {
    await RoomsController.to.init(reload: reload);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rooms'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(10).copyWith(top: 0),
        child: RefreshIndicator(
            onRefresh: () {
              initAllData(reload: true);
              return Future.value();
            },
            child: const RoomView()),
      )),
    );
  }
}
