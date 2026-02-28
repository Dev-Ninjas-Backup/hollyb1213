import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/features/auth/login/facebook_login/facebook_login_services.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:hollyb1213/features/auth/login/services/login_service.dart';
import 'package:hollyb1213/features/auth/role_selection/controller/role_selection_controller.dart';
import 'package:hollyb1213/routes/app_route.dart';

class LoginController extends GetxController {
  final LoginService _loginService = LoginService();
  final SharedPreferenceHelper _prefs = SharedPreferenceHelper();

  var emailOrPhone = ''.obs;
  var password = ''.obs;
  var isPasswordVisible = false.obs;
  var rememberMe = false.obs;
  var isLoading = false.obs;
  var facebookUserData = {}.obs;
  var isFacebookLoggedIn = false.obs;

  RoleSelectionController get role => Get.find<RoleSelectionController>();

  @override
  void onInit() {
    super.onInit();
    _loadSavedCredentials();
    checkFacebookLoginStatus();
  }

  Future<void> _loadSavedCredentials() async {
    final email = await _prefs.getSavedEmail();
    final pass = await _prefs.getSavedPassword();
    if (email != null && pass != null) {
      emailOrPhone.value = email;
      password.value = pass;
      rememberMe.value = true;
    }
  }

  Future<void> checkFacebookLoginStatus() async {
    if (await FacebookLoginServices.isLoggedIn()) {
      final data = await FacebookLoginServices.getUserData();
      if (data != null) {
        facebookUserData.value = data;
        isFacebookLoggedIn.value = true;
      }
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

  Future<void> loginWithFacebook() async {
    try {
      isLoading.value = true;
      final result = await FacebookLoginServices.loginWithFacebook();

      if (result != null) {
        final userData = result['userData'] as Map<String, dynamic>;
        final accessToken = result['accessToken'] as String;

        facebookUserData.value = userData;
        isFacebookLoggedIn.value = true;

        // Persist session to handle app restarts
        await _prefs.saveAuthData(
          accessToken: accessToken,
          refreshToken:
              '', // Facebook client-side login doesn't provide a refresh token
          role: role.selectedRole.value,
          userId: userData['id'],
        );

        print('''
{
  "idToken": "$accessToken",
  "role": "${role.selectedRole.value}"
}
''');
        Get.snackbar('Success', 'Welcome ${userData['name']}!');

        final route = role.selectedRole.value == "employee"
            ? AppRoute.getEmployeeBottomNavbarScreen()
            : AppRoute.getemployerBottomNavbarScreen();
        Get.offAllNamed(route);
      } else {
        Get.snackbar(
          'Login Failed',
          'Facebook login was cancelled or failed.',
        );
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login() async {
    // Validation
    if (emailOrPhone.value.isEmpty || password.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    isLoading.value = true;

    try {
      final response = await _loginService.login(
        email: emailOrPhone.value,
        password: password.value,
      );

      print('Status Code: ${response.statusCode}');
      print('Body: ${response.body}');

      final body = response.body;
      if (body is! Map) {
        print('Server error or offline: $body');
        Get.snackbar(
          'Error',
          'Server is unreachable. Please try again later.',
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      if (body['success'] == true || body['success'] == 'true') {
        print('Login Successful!');

        final data = body['data'];
        final accessToken = data['accessToken'];
        final refreshToken = data['refreshToken'];
        final user = data['user'];
        final role = user['role'];
        final userId = user['id'].toString();

        print('Saving Auth Data: Token: $accessToken, Role: $role');

        await _prefs.saveAuthData(
          accessToken: accessToken,
          refreshToken: refreshToken ?? '',
          role: role,
          userId: userId,
        );

        if (rememberMe.value) {
          await _prefs.saveEmailAndPassword(
              email: emailOrPhone.value, password: password.value);
        } else {
          // If remember me is not checked, clear any previously saved credentials.
          await _prefs.clearEmailAndPassword();
        }

        if (role == 'employee') {
          Get.offAllNamed(AppRoute.getEmployeeBottomNavbarScreen());
        } else {
          Get.offAllNamed(AppRoute.getemployerBottomNavbarScreen());
        }
      } else {
        final message = body['message'] ?? 'Login failed';
        print('API Error: $message');
        Get.snackbar('Error', message, snackPosition: SnackPosition.TOP);
      }
    } catch (e, stackTrace) {
      print('Exception: $e');
      print('StackTrace: $stackTrace');
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logoutFacebook() async {
    await FacebookLoginServices.logoutFromFacebook();
    facebookUserData.value = {};
    isFacebookLoggedIn.value = false;
  }

  Future<void> logout() async {
    isLoading.value = true;
    try {
      // Also logout from Facebook if logged in
      if (isFacebookLoggedIn.value) {
        await logoutFacebook();
      }

      // Clear auth data from SharedPreferences
      await _prefs.clearAll();

      Get.offAllNamed(AppRoute.getloginScreen());
    } finally {
      isLoading.value = false;
    }
  }

  // @override
  //void onClose() {
  //super.onClose();
}
