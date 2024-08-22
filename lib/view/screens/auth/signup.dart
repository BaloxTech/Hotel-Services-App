import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_services_app/common/button.dart';
import 'package:hotel_services_app/common/textfield.dart';
import 'package:hotel_services_app/controller/auth_controller.dart';
import 'package:hotel_services_app/utils/icons.dart';

import '../../../utils/images.dart';

class SignupScreen extends StatefulWidget {
  final bool back;
  const SignupScreen({this.back = false, super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String dialCode = '+92';
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  TextEditingController phone = TextEditingController();
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
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              CustomTextField(
                keyboardType: TextInputType.name,
                controller: name,
                labelText: 'Name',
                hintText: 'Enter your name',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: email,
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: const Icon(FFIcons.email),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: password,
                labelText: 'Password',
                hintText: 'Enter your password',
                obscureText: true,
                prefixIcon: const Icon(FFIcons.lock),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: confirmpassword,
                labelText: 'Confirm Password',
                hintText: 'Enter  password again',
                obscureText: true,
                prefixIcon: const Icon(FFIcons.lock),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  } else if (value != password.text) {
                    return 'Password does not match';
                  }
                  return null;
                },
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
                        favorite: ['+92'],
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
                          horizontal: 10, vertical: 13),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 2, color: Theme.of(context).cardColor),
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(50),
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
              const SizedBox(height: 20),
              OutlineButton(
                text: 'SIGN Up',
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    AuthController.to.signupUser(
                        context,
                        email.text,
                        password.text,
                        name.text,
                        '$dialCode ${phone.text.replaceAll(' ', '')}');
                  }
                },
                boarderSideColor: Theme.of(context).primaryColor,
                buttonInerColor: Theme.of(context).secondaryHeaderColor,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.normal,
                        color: Theme.of(context).cardColor),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Sign In',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: const Color(0xffEB330F),
                            fontWeight: FontWeight.normal)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
