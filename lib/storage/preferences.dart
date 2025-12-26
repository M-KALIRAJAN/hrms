import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  // 🔑 KEYS
  static const String _tokenKey = "auth_token";
  static const String _userIdKey = "user_id";
  static const String _companyIdKey = "company_id";
  static const String _locationIdKey = "location_id";
  static const String _userNameKey = "employee_name";
  static const String _loginKey = "is_logged_in";
  /// ================= TOKEN =================
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey) ?? '';
  }

  /// ================= USER ID =================
  static Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, userId);
  }

  static Future<String> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey) ?? '';
  }

  /// ================= COMPANY ID =================
  static Future<void> saveCompanyId(int companyId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_companyIdKey, companyId);
  }

  static Future<int> getCompanyId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_companyIdKey) ?? 0;
  }

  /// ================= LOCATION ID =================
  static Future<void> saveLocationId(int locationId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_locationIdKey, locationId);
  }

  static Future<int> getLocationId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_locationIdKey) ?? 0;
  }

  /// ================= USER NAME (OPTIONAL) =================
  static Future<void> saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userNameKey, name);
  }

  static Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userNameKey) ?? '';
  }
  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loginKey, value);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_loginKey) ?? false;
  }
  /// ================= CLEAR ALL =================
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
