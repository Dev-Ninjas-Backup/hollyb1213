import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/features/employee/profile_screen/profile/widgets/profile_service.dart';

class ChangePasswordController extends GetxController {
  final ProfileService _profileService = Get.find<ProfileService>();

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isLoading = false.obs;
  var isOldPasswordVisible = false.obs;
  var isNewPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  void toggleOldPasswordVisibility() {
    isOldPasswordVisible.value = !isOldPasswordVisible.value;
  }

  void toggleNewPasswordVisibility() {
    isNewPasswordVisible.value = !isNewPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<void> changePassword() async {
    if (oldPasswordController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar('Error', 'All fields are required.',
          snackPosition: SnackPosition.TOP);
      return;
    }

    if (newPasswordController.text != confirmPasswordController.text) {
      Get.snackbar('Error', 'New passwords do not match.',
          snackPosition: SnackPosition.TOP);
      return;
    }

    isLoading.value = true;
    try {
      final response = await _profileService.changePassword(
        oldPassword: oldPasswordController.text,
        newPassword: newPasswordController.text,
      );

      final body = response.body;

      if (response.isOk && body != null && body['success'] == true) {
        Get.back(); // Go back to profile screen
        Get.snackbar('Success', 'Password changed successfully.',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Appcolor.primaryColor,
            colorText: Colors.white);
      } else {
        String message = 'Failed to change password.';
        if (body != null && body is Map && body['message'] != null) {
          message = body['message'];
        }
        Get.snackbar('Error', message,
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e',
          snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
