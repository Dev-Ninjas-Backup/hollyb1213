import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/constants/widget/custom_button.dart';
import 'package:hollyb1213/features/employee/profile_screen/profile/widgets/change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ChangePasswordController ctrl = Get.put(ChangePasswordController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        centerTitle: true,
        backgroundColor: Appcolor.backgroundcolor,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Appcolor.backgroundcolor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            Obx(
              () => TextField(
                controller: ctrl.oldPasswordController,
                obscureText: !ctrl.isOldPasswordVisible.value,
                decoration: InputDecoration(
                  hintText: "Old Password",
                  prefixIcon:
                      const Icon(Icons.lock_outline, color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: Icon(
                      ctrl.isOldPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: ctrl.toggleOldPasswordVisibility,
                  ),
                  filled: true,
                  fillColor: Appcolor.appSecondaryColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Obx(
              () => TextField(
                controller: ctrl.newPasswordController,
                obscureText: !ctrl.isNewPasswordVisible.value,
                decoration: InputDecoration(
                  hintText: "New Password",
                  prefixIcon:
                      const Icon(Icons.lock_outline, color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: Icon(
                      ctrl.isNewPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: ctrl.toggleNewPasswordVisibility,
                  ),
                  filled: true,
                  fillColor: Appcolor.appSecondaryColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Obx(
              () => TextField(
                controller: ctrl.confirmPasswordController,
                obscureText: !ctrl.isConfirmPasswordVisible.value,
                decoration: InputDecoration(
                  hintText: "Confirm New Password",
                  prefixIcon:
                      const Icon(Icons.lock_outline, color: Colors.grey),
                  suffixIcon: IconButton(
                    icon: Icon(
                      ctrl.isConfirmPasswordVisible.value
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: ctrl.toggleConfirmPasswordVisibility,
                  ),
                  filled: true,
                  fillColor: Appcolor.appSecondaryColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
            Obx(
              () => ctrl.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Appcolor.primaryColor,
                      ),
                    )
                  : CustomButton(
                      buttonText: "Update Password",
                      onTap: ctrl.changePassword,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
