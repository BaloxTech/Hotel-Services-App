import 'package:hotel_services_app/data/model/body/language.dart';
import 'package:hotel_services_app/utils/app_constants.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages() {
    return AppConstants.languages;
  }
}
