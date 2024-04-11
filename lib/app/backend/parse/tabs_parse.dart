import 'package:sylph/app/backend/api/api.dart';
import 'package:sylph/app/helper/SharedPreferencesManager.dart';

class TabsParser {
  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  TabsParser({required this.sharedPreferencesManager, required this.apiService});

}