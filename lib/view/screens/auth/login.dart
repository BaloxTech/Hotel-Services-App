import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:hotel_services_app/common/button.dart';
import 'package:hotel_services_app/common/textfield.dart';
import 'package:hotel_services_app/controller/auth_controller.dart';
import 'package:hotel_services_app/helper/navigation.dart';
import 'package:hotel_services_app/utils/icons.dart';
import 'package:hotel_services_app/view/screens/auth/signup.dart';
import 'package:hotel_services_app/view/screens/auth/widget/verify_email_dialog.dart';

import '../../../utils/images.dart';

class LoginScreen extends StatefulWidget {
  final bool verificationn;
  final bool back;
  const LoginScreen({this.verificationn = false, this.back = true, super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    if (widget.verificationn) {
      SchedulerBinding.instance.addPostFrameCallback((_) {
        showDialog(
            context: context, builder: (context) => const VerifyEmailDialog());
      });
    }
    super.initState();
  }

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
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.3),
            CustomTextField(
              controller: email,
              labelText: 'Email',
              hintText: 'Enter your email',
              prefixIcon: const Icon(FFIcons.email),
            ),
            CustomTextField(
              controller: password,
              obscureText: true,
              labelText: 'Password',
              hintText: 'Enter your password',
              prefixIcon: const Icon(FFIcons.lock),
            ),
            const SizedBox(height: 20),
            OutlineButton(
              text: 'SIGN IN',
              onPressed: () {
                AuthController.to.loginUser(context, email.text, password.text);
              },
              boarderSideColor: Theme.of(context).primaryColor,
              buttonInerColor: Theme.of(context).secondaryHeaderColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Don\'t have an account?',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).cardColor),
                ),
                TextButton(
                  onPressed: () {
                    launchScreen(const SignupScreen());
                  },
                  child: Text('Sign Up',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: const Color(0xffEB330F),
                          fontWeight: FontWeight.normal)),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
