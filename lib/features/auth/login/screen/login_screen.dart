import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/core/common/constants/widget/custom_button.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/auth/login/controller/login_controller.dart';
import 'package:hollyb1213/routes/app_route.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController ctrl = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Appcolor.backgroundcolor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: height),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [
                SizedBox(height: 80),
                Text(
                  "Welcome ",
                  textAlign: TextAlign.center,
                  style: getTextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Appcolor.primaryColor,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Your next opportunity is just a tap away.",
                  textAlign: TextAlign.center,
                  style: getBodyTextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 70),

                TextField(
                  onChanged: (value) => ctrl.emailOrPhone.value = value,
                  decoration: InputDecoration(
                    hintText: "Enter your email or phone",
                    prefixIcon: Icon(Icons.email_outlined, color: Colors.grey),

                    filled: true,
                    fillColor: Appcolor.appSecondaryColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 16),

                Obx(
                  () => TextField(
                    onChanged: (value) => ctrl.password.value = value,
                    obscureText: !ctrl.isPasswordVisible.value,
                    decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.lock_outline, color: Colors.grey),
                      suffixIcon: IconButton(
                        icon: Icon(
                          ctrl.isPasswordVisible.value
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: ctrl.togglePasswordVisibility,
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
                SizedBox(height: 8),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Row(
                        children: [
                          Checkbox(
                            value: ctrl.rememberMe.value,
                            onChanged: ctrl.toggleRememberMe,
                          ),
                          Text("Remember me"),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoute.getforgotPasswordScreen());
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(50, 30),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Appcolor.primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 60),

                CustomButton(
                  buttonText: "Login",
                  onTap: () {
                    Get.offAndToNamed(AppRoute.gethomeScreen());
                  },
                ),

                SizedBox(height: 60),

                Row(
                  children: [
                    Expanded(child: Divider(thickness: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("or"),
                    ),
                    Expanded(child: Divider(thickness: 1)),
                  ],
                ),
                SizedBox(height: 40),

                // Social login buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Appcolor.appBorderColor,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Image.asset(Iconpath.google),
                        iconSize: 21,
                      ),
                    ),
                    SizedBox(width: 24),

                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Appcolor.appBorderColor,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: Image.asset(Iconpath.fecebook),
                        iconSize: 24,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 80),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don’t have an account? "),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(AppRoute.getsingUpScreen());
                      },
                      child: Text(
                        "Signup",
                        style: getTextStyle(
                          color: Appcolor.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
