import 'package:sylph/app/backend/api/api.dart';
import 'package:sylph/app/helper/SharedPreferencesManager.dart';

class ContactUsParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  ContactUsParse({required this.sharedPreferencesManager, required this.apiService});


}