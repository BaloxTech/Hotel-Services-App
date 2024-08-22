import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/localization_controller.dart';
import '../data/model/body/language.dart';
import '../utils/app_constants.dart';

class LanguageDialog extends StatefulWidget {
  const LanguageDialog({Key? key}) : super(key: key);
  @override
  LanguageDialogState createState() => LanguageDialogState();
}

class LanguageDialogState extends State<LanguageDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Theme.of(context).cardColor,
      shape: ShapeBorder.lerp(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          1),
      title: Text("select_language".tr),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: GetBuilder<LocalizationController>(builder: (con) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: AppConstants.languages.length,
                itemBuilder: (BuildContext context, int index) {
                  LanguageModel language = AppConstants.languages[index];
                  return RadioListTile(
                    secondary: Image.asset(
                      language.imageUrl,
                      height: 30,
                      width: 30,
                    ),
                    title: Text(language.languageName),
                    value: con.selectedIndex == index
                        ? language.languageName
                        : null,
                    groupValue: language.languageName,
                    controlAffinity: ListTileControlAffinity.trailing,
                    onChanged: (value) {
                      con.setSelectIndex(index);
                      // set language
                      LocalizationController.to.setLanguage(
                          Locale(language.languageCode, language.countryCode));
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'ok'.tr,
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}
