import 'package:sylph/app/backend/api/api.dart';
import 'package:sylph/app/helper/SharedPreferencesManager.dart';

class PurchaseParse {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  PurchaseParse({required this.sharedPreferencesManager, required this.apiService});

}