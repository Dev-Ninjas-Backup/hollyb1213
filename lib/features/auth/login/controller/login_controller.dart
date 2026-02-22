// ignore_for_file: avoid_print

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:hollyb1213/features/auth/login/services/login_service.dart';
import 'package:hollyb1213/routes/app_route.dart';

class LoginController extends GetxController {
  final LoginService _loginService = LoginService();
  final SharedPreferenceHelper _prefs = SharedPreferenceHelper();

  var emailOrPhone = ''.obs;
  var password = ''.obs;
  var isPasswordVisible = false.obs;
  var rememberMe = false.obs;
  var isLoading = false.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

  Future<void> login() async {
    print('===== LOGIN CALLED =====');
    print('Email: ${emailOrPhone.value}');

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

        final accessToken = body['data']['accessToken'];
        final refreshToken = body['data']['refreshToken'];
        final user = body['data']['user'];
        final role = user['role'];
        final userId = user['id'];

        print('role: $role, userId: $userId');

        await _prefs.saveAuthData(
          accessToken: accessToken,
          refreshToken: refreshToken,
          role: role,
          userId: userId,
        );

        if (rememberMe.value) {
          await _prefs.saveEmailAndPassword(
            email: emailOrPhone.value,
            password: password.value,
          );
          print('Email & password saved for Remember Me');
        }

        print('Auth data saved — role: $role, userId: $userId');

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
      print('===== DONE =====');
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
