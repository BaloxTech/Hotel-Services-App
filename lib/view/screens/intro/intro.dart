import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_services_app/common/button.dart';
import 'package:hotel_services_app/helper/navigation.dart';
import 'package:hotel_services_app/utils/images.dart';
import 'package:hotel_services_app/view/screens/auth/login.dart';

import '../auth/signup.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: Get.height * 1,
      width: Get.width * 1,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Images.background), fit: BoxFit.cover)),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1),
          Image.asset(
            Images.logoWhite,
            width: MediaQuery.of(context).size.width,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlineButton(
                  text: 'SIGN IN',
                  onPressed: () {
                    launchScreen(const LoginScreen());
                  },
                  boarderSideColor: Theme.of(context).primaryColor,
                  buttonInerColor: Theme.of(context).secondaryHeaderColor,
                ),
                const SizedBox(height: 20),
                OutlineButton(
                  text: 'SIGN UP',
                  onPressed: () {
                    launchScreen(const SignupScreen());
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
