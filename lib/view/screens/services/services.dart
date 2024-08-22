import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hotel_services_app/common/button.dart';
import 'package:hotel_services_app/common/loading.dart';
import 'package:hotel_services_app/common/snackbar.dart';
import 'package:hotel_services_app/common/tabbutton.dart';
import 'package:hotel_services_app/common/textfield.dart';
import 'package:hotel_services_app/controller/service_controller.dart';
import 'package:hotel_services_app/helper/navigation.dart';
import 'package:hotel_services_app/utils/images.dart';
import 'package:hotel_services_app/utils/style.dart';
import 'package:hotel_services_app/view/screens/webview/webview.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController room = TextEditingController();
  TextEditingController description = TextEditingController();
  int? selectedService;
  @override
  void initState() {
    initAllData();
    super.initState();
  }

  initAllData({bool reload = false}) async {
    await ServiceController.to.init(reload: reload);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Images.background), fit: BoxFit.cover)),
          ),
          SizedBox(
            height: getPixels(context, 200),
            width: double.infinity,
            child: Image.asset(
              Images.car,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              height: MediaQuery.of(context).size.height * .55,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(radius),
                    ),
                    child: Row(
                      children: [
                        AnimatedTabButton(
                          text: 'All',
                          onTap: () {},
                          selected: true,
                        ),
                        const SizedBox(width: 5),
                        AnimatedTabButton(
                          text: 'Shuttle',
                          onTap: () {
                            launchScreen(const LoadWebView(
                                url:
                                    'https://www.leparis.nc/reserver-navette/'));
                          },
                          selected: false,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: SingleChildScrollView(
                      child: GetBuilder<ServiceController>(builder: (con) {
                        return con.isLoading
                            ? const Center(
                                child: Loading(),
                              )
                            : Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    CustomDropDown(
                                        labelText: 'Service',
                                        hintText: 'Select service',
                                        items: con.serviceList
                                            .map((e) => DropdownMenuItem(
                                                value: e.id,
                                                child: Text(e.title!,
                                                    style: const TextStyle(
                                                        fontSize: 14))))
                                            .toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            selectedService = value as int?;
                                          });
                                        }),
                                    CustomTextField(
                                      fillColor:
                                          Theme.of(context).disabledColor,
                                      boderRadius: 5,
                                      controller: room,
                                      hintText: 'Enter room number',
                                      labelText: 'Room',
                                      keyboardType: TextInputType.number,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter room number';
                                        }
                                        return null;
                                      },
                                    ),
                                    CustomTextField(
                                      fillColor:
                                          Theme.of(context).disabledColor,
                                      boderRadius: 5,
                                      controller: description,
                                      hintText: 'Enter description',
                                      labelText: 'Description',
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter description';
                                        }
                                        return null;
                                      },
                                    ),
                                    SizedBox(height: Get.width * 0.1),
                                    CustomButton(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .05,
                                        text: 'Book',
                                        onPressed: () async {
                                          if (selectedService == null) {
                                            getSnackBar('Please select service',
                                                success: false);
                                          } else {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              await ServiceController.to
                                                  .bookService(
                                                      selectedService!,
                                                      room.text,
                                                      description.text);
                                              room.clear();
                                              description.clear();
                                            }
                                          }
                                        })
                                  ],
                                ),
                              );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
