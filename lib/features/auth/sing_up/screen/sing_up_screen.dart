import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readytowork/core/common/constants/appcolor.dart';
import 'package:readytowork/core/common/constants/widget/custom_back_button.dart';
import 'package:readytowork/core/common/constants/widget/custom_button.dart';
import 'package:readytowork/core/common/style/global_text_style.dart';
import 'package:readytowork/features/auth/sing_up/controller/sing_up_controller.dart';


class SingUpScreen extends StatelessWidget {
  SingUpScreen({super.key});

  final SingUpController ctrl = Get.put(SingUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.backgroundcolor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            Stack(
              alignment: Alignment.center,
              children: [
                CustomBackButton(),
                Center(
                  child: Text(
                    "Create Your Account",
                    style: getTextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 22.h),

            buildTextField(
              label: 'Full Name',
              hint: 'Enter your full name',
              icon: Icons.person_outline,
              onChanged: (val) => ctrl.name.value = val,
            ),
            SizedBox(height: 16.h),

            buildTextField(
              label: 'Email or Phone',
              hint: 'Enter your email or phone',
              icon: Icons.email_outlined,
              onChanged: (val) => ctrl.email.value = val,
            ),
            SizedBox(height: 16.h),

            Obx(
              () => buildTextField(
                label: 'Enter Your Password',
                hint: '********',
                icon: Icons.lock_outline,
                obscureText: !ctrl.isPasswordVisible.value,
                suffixIcon: IconButton(
                  icon: Icon(
                    ctrl.isPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: ctrl.togglePasswordVisibility,
                ),
                onChanged: (val) => ctrl.password.value = val,
              ),
            ),
            SizedBox(height: 16.h),

            Obx(
              () => buildTextField(
                label: 'Confirm Your Password',
                hint: '********',
                icon: Icons.lock_outline,
                obscureText: !ctrl.isConfirmPasswordVisible.value,
                suffixIcon: IconButton(
                  icon: Icon(
                    ctrl.isConfirmPasswordVisible.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.grey,
                  ),
                  onPressed: ctrl.toggleConfirmPasswordVisibility,
                ),
                onChanged: (val) => ctrl.confirmPassword.value = val,
              ),
            ),
            SizedBox(height: 50.h),
            Obx(
              () => ctrl.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Appcolor.primaryColor,
                      ),
                    )
                  : CustomButton(
                      buttonText: "Create account",
                      onTap: ctrl.createAccount,
                    ),
            ),
            SizedBox(height: 30.h),

            Row(
              children: [
                Expanded(child: Divider(height: 1.h)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w),
                  child: Text('or'),
                ),
                Expanded(child: Divider(height: 1.h)),
              ],
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                SizedBox(width: 24),

              ],
            ),

            SizedBox(height: 16.h),

            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: getBodyTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      'Login',
                      style:
                          getTextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ).copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: Appcolor.primaryColor,
                            decorationThickness: 1.5,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    required Function(String) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: getBodyTextStyle(fontSize: 14, fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 6.h),
        TextField(
          onChanged: onChanged,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: getBodyTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: Icon(icon, color: Colors.grey),
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Appcolor.appSecondaryColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.r),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
