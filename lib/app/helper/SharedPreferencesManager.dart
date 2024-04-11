import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  SharedPreferences? sharedPreferences;

  static const String keyAccessToken = 'accessToken';
  static const String keyUserData = 'user_data';
  static const String keyRole = 'user_role';
  static const String keyFcmToken = 'fcm_token';

  SharedPreferencesManager({required this.sharedPreferences});

  String? getString(String key) {
    sharedPreferences?.getString(key);
  }

  double?getDouble(String key) {
    sharedPreferences?.getDouble(key);
  }

  int? getInt(String key) {
    sharedPreferences?.getInt(key);
  }

  Future<bool>? putString(String key, String value) => sharedPreferences?.setString(key, value);
}