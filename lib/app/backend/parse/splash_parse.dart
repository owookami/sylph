import 'package:sylph/app/backend/api/api.dart';
import 'package:sylph/app/helper/SharedPreferencesManager.dart';

class SplashScreenParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  SplashScreenParse({
    required this.sharedPreferencesManager,
    required this.apiService,
  });
}