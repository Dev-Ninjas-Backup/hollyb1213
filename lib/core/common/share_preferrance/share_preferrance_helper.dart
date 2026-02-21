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

  /// Ekbare Token, Role ebong Status save korar jonno
  Future<void> saveAuthData({
    required String accessToken,
    required String refreshToken,
    required String role,
    String? userId,
  }) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Token save korar somoy 'Bearer ' prefix auto add kora thakle bhalo
    await prefs.setString(_accessTokenKey, 'Bearer $accessToken');
    await prefs.setString(_refreshTokenKey, refreshToken);
    await prefs.setString(_selectedRoleKey, role);
    if (userId != null) await prefs.setString(_userIdKey, userId);

    // Login success status
    await prefs.setBool(_isLoggedInKey, true);
  }

  // Check if User is Logged In
  Future<bool> checkLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // --- Getters ---

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

  // --- User Profile Data (Optional/Remember Me) ---

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

  // Private Helper to reduce code repetition
  Future<String?> _getString(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // --- Clear Data (Logout) ---

  Future<void> clearAll() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
