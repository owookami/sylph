import 'package:sylph/app/backend/api/api.dart';
import 'package:sylph/app/helper/SharedPreferencesManager.dart';

class HomeParse {

  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  HomeParse({required this.sharedPreferencesManager, required this.apiService});

}