import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:hotel_services_app/controller/theme_controller.dart';
import 'package:hotel_services_app/utils/app_constants.dart';
import 'common/loading.dart';
import 'helper/get_di.dart' as di;
import 'controller/localization_controller.dart';
import 'theme/dark_theme.dart';
import 'theme/light_theme.dart';
import 'utils/messages.dart';
import 'view/screens/splash/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Map<String, Map<String, String>> languages = await di.init();
  await Firebase.initializeApp();
  runApp(MyApp(languages: languages));
}

class MyApp extends StatelessWidget {
  final Map<String, Map<String, String>> languages;
  const MyApp({required this.languages, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: ((themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        return GetMaterialApp(
          title: AppConstants.APP_NAME,
          debugShowCheckedModeBanner: false,
          theme: themeController.darkTheme
              ? themeController.darkColor == null
                  ? dark()
                  : dark(color: themeController.darkColor!)
              : themeController.lightColor == null
                  ? light()
                  : light(color: themeController.lightColor!),
          locale: localizeController.locale,
          translations: Messages(languages: languages),
          fallbackLocale: Locale(AppConstants.languages[0].languageCode,
              AppConstants.languages[0].countryCode),
          builder: FlutterSmartDialog.init(loadingBuilder: (string) {
            return const Loadingg();
          }),
          home: const SplashScreen(),
        );
      });
    }));
  }
}
