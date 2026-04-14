// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:readytowork/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:readytowork/features/auth/sing_up/services/singup_service.dart';
import 'package:readytowork/routes/app_route.dart';


class SingUpController extends GetxController {
  final SingupService _singupService = SingupService();
  final SharedPreferenceHelper _prefs = SharedPreferenceHelper();

  var name = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;
  var role = ''.obs;

  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadRole();
  }

  Future<void> _loadRole() async {
    final savedRole = await _prefs.getSelectedRole();
    if (savedRole != null && savedRole.isNotEmpty) {
      role.value = savedRole;
      print('Role loaded from SharedPrefs: ${role.value}');
    } else {
      print('No role found in SharedPrefs!');
    }
  }

  bool get isButtonEnabled =>
      name.isNotEmpty &&
      email.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty &&
      password.value == confirmPassword.value;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<void> createAccount() async {
    print('Name: ${name.value}');
    print('Email: ${email.value}');
    print('Role: ${role.value}');

    if (name.value.isEmpty ||
        email.value.isEmpty ||
        password.value.isEmpty ||
        confirmPassword.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill in all fields',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (password.value != confirmPassword.value) {
      Get.snackbar(
        'Error',
        'Passwords do not match',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    if (role.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Role not found. Please go back and select a role.',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    isLoading.value = true;

    try {
      final response = await _singupService.register(
        fullName: name.value,
        email: email.value,
        password: password.value,
        role: role.value,
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

      if (response.statusCode == 201 && body['success'] == true) {
        print('Registration Successful!');

        final userId = body['data']['userId'];
        final userEmail = body['data']['email'];

        Get.toNamed(
          AppRoute.getverificationScreen(),
          arguments: {'userId': userId, 'email': userEmail},
        );
      } else {
        final message = body['message'] ?? 'Registration failed';
        Get.snackbar('Error', message, snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      print('Exception: $e');
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
