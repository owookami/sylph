import 'package:sylph/app/backend/api/api.dart';
import 'package:sylph/app/helper/SharedPreferencesManager.dart';

class ProfileParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  ProfileParse({required this.sharedPreferencesManager, required this.apiService});


}