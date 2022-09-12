



import 'package:shared_preferences/shared_preferences.dart';

class Session {
  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var value;

  static Future<String> getEmail() async {
    final SharedPreferences preferences = await _prefs;
    return preferences.getString("email");
  }
  static Future<String> getUsername() async {
    final SharedPreferences preferences = await _prefs;
    return preferences.getString("username");
  }
  static Future<String> getKaryawanId() async {
    final SharedPreferences preferences = await _prefs;
    return preferences.getString("karyawan_id");
  }
  static Future<String> getKaryawanNama() async {
    final SharedPreferences preferences = await _prefs;
    return preferences.getString("karyawan_nama");
  }
  static Future<String> getKaryawanNo() async {
    final SharedPreferences preferences = await _prefs;
    return preferences.getString("karyawan_no");
  }

}