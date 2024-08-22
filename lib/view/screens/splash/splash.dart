import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_services_app/controller/auth_controller.dart';
import 'package:hotel_services_app/helper/navigation.dart';
import 'package:hotel_services_app/utils/images.dart';
import 'package:hotel_services_app/view/screens/auth/login.dart';
import 'package:hotel_services_app/view/screens/auth/signup.dart';
import 'package:hotel_services_app/view/screens/dashboard/dashboard.dart';

import '../intro/intro.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser;

  double initialWidth = 300;
  double initialHeight = 300;
  double borderRadius = 300;

  @override
  void initState() {
    iniData();
    Future.delayed(const Duration(seconds: 1), () {
      changeSize();
    });
    super.initState();
  }

  changeSize() {
    setState(() {
      initialWidth = 270;
      initialHeight = 270;
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          borderRadius = 0;
          initialWidth = MediaQuery.of(context).size.width;
          initialHeight = MediaQuery.of(context).size.height;
        });
      });
    });
  }

  iniData() async {
    bool isUserExist = await checkUser();
    Future.delayed(const Duration(seconds: 2), () {
      launchScreen(getHomepPage(isUserExist), replace: true);
    });
  }

  Widget getHomepPage(bool value) {
    if (user != null && value) {
      if (user != null && !user!.emailVerified) {
        return const LoginScreen(verificationn: true, back: false);
      } else {
        return const DashboardPage();
      }
    } else if (user != null && value == false) {
      return const SignupScreen(back: false);
    } else {
      return const IntroPage();
    }
  }

  Future<bool> checkUser() async {
    if (FirebaseAuth.instance.currentUser != null) {
      return AuthController.to
          .isUserExist(FirebaseAuth.instance.currentUser!.email!);
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height * 1,
        width: Get.width * 1,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(Images.background), fit: BoxFit.cover)),
        child: Center(
            child: AnimatedContainer(
          width: initialWidth,
          height: initialHeight,
          duration: const Duration(milliseconds: 300),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(borderRadius)),
          child: Image.asset(
            Images.logoSplash,
            fit: BoxFit.cover,
          ),
        )),
      ),
    );
  }
}
