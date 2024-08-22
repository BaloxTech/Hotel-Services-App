// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:hotel_services_app/common/button.dart';
import 'package:hotel_services_app/common/icons.dart';
import 'package:hotel_services_app/common/tabbutton.dart';
import 'package:hotel_services_app/controller/auth_controller.dart';
import 'package:hotel_services_app/data/model/response/user.dart';
import 'package:hotel_services_app/utils/icons.dart';
import 'package:hotel_services_app/utils/network_image.dart';

import 'package:image_picker/image_picker.dart';

import '../../../common/textfield.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  AppUser user = AuthController.to.appUser!;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  String dialCode = '+92';
  File? image;

  @override
  void initState() {
    name.text = user.name!;
    email.text = user.email!;
    phone.text = user.phone!.split(' ').last;
    dialCode = user.phone!.split(' ').first;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text('Edit Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                // profile image
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(100)),
                          child: image == null
                              ? CustomNetworkImage(
                                  loadingRadius: 50, url: user.image)
                              : Image.file(image!, fit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: CustomIcon(
                          icon: FFIcons.camera,
                          onTap: () async {
                            image = await pickImage();
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                CustomTextField(
                  controller: name,
                  labelText: 'Name',
                  hintText: 'Enter your name',
                ),
                CustomTextField(
                  readOnly: true,
                  controller: email,
                  labelText: 'Email (Unchangeable)',
                  hintText: 'Enter your email',
                ),
                const SizedBox(height: 20),
                Text(
                  'Phone Number',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Theme.of(context).hintColor),
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          showPhoneCode: true,
                          countryListTheme: CountryListThemeData(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor),
                          onSelect: (Country country) {
                            setState(() {
                              dialCode = "+${country.phoneCode}";
                            });
                          },
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 15),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Text(dialCode,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Theme.of(context).hintColor)),
                            const SizedBox(width: 5),
                            const Icon(FFIcons.downArrow,
                                color: Colors.grey, size: 15),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomTextField(
                        padding: const EdgeInsets.only(top: 5),
                        controller: phone,
                        hintText: 'Enter phone number',
                        prefixIcon: Icon(Icons.call,
                            size: 20, color: Theme.of(context).hintColor),
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                CustomButton(
                  text: 'Save',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      AuthController.to.updateUser(
                          AppUser(
                            name: name.text,
                            email: email.text,
                            phone:
                                '$dialCode ${phone.text.replaceAll(' ', '')}',
                            image: user.image,
                          ),
                          image);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<File?> pickImage() async {
    var selectedImage = await ImagePicker.platform
        .getImageFromSource(source: ImageSource.gallery);
    if (selectedImage == null) {
      return null;
    } else {
      File file = File(selectedImage.path);
      return file;
    }
  }
}
