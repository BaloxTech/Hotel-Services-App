import 'package:flutter/material.dart';
import 'package:hotel_services_app/controller/auth_controller.dart';
import 'package:hotel_services_app/controller/cart_controller.dart';
import 'package:hotel_services_app/utils/images.dart';
import 'package:hotel_services_app/view/screens/cart/cart.dart';
import 'package:hotel_services_app/view/screens/home/home.dart';
import 'package:hotel_services_app/view/screens/rooms/rooms.dart';
import 'package:hotel_services_app/view/screens/services/services.dart';
import 'package:hotel_services_app/view/screens/settings/settings.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 2;
  List<Widget> pages = const [
    RoomsScreen(),
    CartScreen(),
    HomeScreen(),
    ServicesScreen(),
    SettingPage()
  ];

  @override
  void initState() {
    AuthController.to.getUser();
    CartController.to.getCartList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: InkWell(
        onTap: () {
          setState(() {
            _selectedIndex = 2;
          });
        },
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          color: Colors.transparent,
          height: 80,
          width: 40,
          child: Stack(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(Images.polygon),
              CircleAvatar(
                radius: 30,
                child: Image.asset(
                  Images.home,
                  color: _selectedIndex == 2
                      ? Colors.white
                      : Theme.of(context).hintColor,
                  height: 20,
                ),
              )
            ],
          ),
        ),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Theme.of(context).hintColor,
          backgroundColor: Theme.of(context).primaryColor,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: [
            // _bottomItem(Images.home, 'home'.tr),
            _bottomItem(Images.rooms, ''),
            _bottomItem(Images.cart, ''),
            const BottomNavigationBarItem(icon: SizedBox(), label: ''),
            _bottomItem(Images.servicesIcon, ''),
            _bottomItem(Images.settings, ''),
          ]),
    );
  }

  _bottomItem(String image, String label) => BottomNavigationBarItem(
      backgroundColor: Theme.of(context).cardColor,
      icon: Image.asset(
        image,
        width: 20,
        color: Theme.of(context).hintColor,
      ),
      activeIcon: Image.asset(
        image,
        width: 20,
        color: Colors.white,
      ),
      label: label);
}
