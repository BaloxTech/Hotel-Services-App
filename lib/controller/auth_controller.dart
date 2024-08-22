import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../common/snackbar.dart';
import '../data/api/api_client.dart';
import '../data/model/response/user.dart';
import '../data/repository/auth_repo.dart';
import '../helper/navigation.dart';
import '../view/screens/auth/login.dart';
import '../view/screens/auth/widget/verify_email_dialog.dart';
import '../view/screens/dashboard/dashboard.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  FirebaseAuth auth = FirebaseAuth.instance;
  AppUser? appUser;
  User? get user => FirebaseAuth.instance.currentUser;

  Future<bool> isUserExist(String email) async {
    var response = await authRepo.isUserExist(email);
    if (response != NO_INTERNET) {
      response = jsonDecode(response.body);
      if (response['status'] == true) {
        token = response['token'];
      }
      return response['status'];
    } else {
      errorMessage();
      return false;
    }
  }

  Future<void> getUser() async {
    appUser = await authRepo.getUser(user!.email!);
    update();
  }

  loginUser(BuildContext context, String email, String password) async {
    email = email.trim().toLowerCase();
    SmartDialog.showLoading();
    // is user exists
    bool exist = await isUserExist(email);
    if (exist) {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        SmartDialog.dismiss();
        if (!value.user!.emailVerified) {
          showDialog(
              context: context,
              builder: (context) => const VerifyEmailDialog(fromSignUp: false));
        } else {
          getUser();
          launchScreen(const DashboardPage(), replace: true);
        }
      }).catchError((e) {
        SmartDialog.dismiss();
        getSnackBar('${e.message}', success: false);
      });
    } else {
      SmartDialog.dismiss();
      getSnackBar('User not found', success: false);
    }
  }

  Future<void> signupUser(BuildContext context, String email, String password,
      String name, String phone) async {
    SmartDialog.showLoading();
    email = email.trim().toLowerCase();
    bool userExist = await isUserExist(email);
    if (userExist) {
      SmartDialog.dismiss();
      getSnackBar('User already exists', success: false);
    } else {
      return auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        User user = value.user!;
        user.updateDisplayName(name);
        await authRepo.saveUser(
            AppUser(email: email, name: name, phone: phone, password: password)
                .toJson());
        //get updated user
        await user.reload();
        SmartDialog.dismiss();
        // ignore: use_build_context_synchronously
        showDialog(
            context: context, builder: (context) => const VerifyEmailDialog());
      }).catchError((e) {
        SmartDialog.dismiss();
        getSnackBar('${e.message}', success: false);
      });
    }
  }

  updateUser(AppUser user, File? image) async {
    SmartDialog.showLoading();
    if (image != null) {
      await authRepo.uploadUserImage(user.email!, image);
      await getUser();
      user.image = appUser!.image;
    }
    user.password = appUser!.password;
    await authRepo.updateUser(user.toJson());
    SmartDialog.dismiss();
    getSnackBar('Profile updated successfully');
  }

  logoutUser() async {
    await FirebaseAuth.instance.signOut();
    launchScreen(const LoginScreen(back: false), replace: true);
  }

  static AuthController get to => Get.find();
}
