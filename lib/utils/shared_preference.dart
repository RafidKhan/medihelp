import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static Future<String?> read(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(key);
    } catch (e) {
      return null;
    }
  }

  static Future<bool> write(String key, dynamic value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      value = "$value";
      return prefs.setString(key, value);
    } catch (e) {
      return false;
    }
  }

  static Future<bool> remove(String key) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.remove(key);
    } catch (e) {
      return false;
    }
  }

  static Future<bool> removeAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      var keys = prefs.getKeys();

      for (var key in keys) {
        prefs.remove(key);
      }
      return true;
    } catch (e) {
      return false;
    }
  }
}
