import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  // Keys
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _selectedRoleKey = 'selected_role';
  static const String _userIdKey = 'user_id';

  static const String _emailKey = 'email';
  static const String _passwordKey = 'password';
  static const String _userName = 'user_name';
  static const String _phoneNumber = 'phone_number';

  // --- Auth & Session Management ---

  Future<void> saveAuthData({
    required String accessToken,
    required String refreshToken,
    required String role,
    String? userId,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, accessToken);
    await prefs.setString(_refreshTokenKey, refreshToken);
    await prefs.setString(_selectedRoleKey, role);
    if (userId != null) await prefs.setString(_userIdKey, userId);
    await prefs.setBool(_isLoggedInKey, true);
  }

  Future<void> saveSelectedRole(String role) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedRoleKey, role);
  }

  // Check if User is Logged In
  Future<bool> checkLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  Future<String?> getAccessToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  Future<String?> getSelectedRole() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_selectedRoleKey);
  }

  Future<String?> getUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  Future<void> saveEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, email);
    await prefs.setString(_passwordKey, password);
  }

  Future<void> saveUserNameAndPhone({
    required String userName,
    required String phoneNumber,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userName, userName);
    await prefs.setString(_phoneNumber, phoneNumber);
  }

  Future<String?> getSavedEmail() => _getString(_emailKey);
  Future<String?> getSavedPassword() => _getString(_passwordKey);
  Future<String?> getSavedUserName() => _getString(_userName);
  Future<String?> getSavedPhoneNumber() => _getString(_phoneNumber);

  Future<String?> _getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  Future<void> clearEmailAndPassword() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_emailKey);
    await prefs.remove(_passwordKey);
  }

  Future<void> clearAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
