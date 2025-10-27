import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/core/common/constants/widget/custom_button.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/auth/forgot_password/controller/forgot_password_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final ForgotPasswordController ctrl = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Appcolor.backgroundcolor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height * 0.06),

            Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.arrow_back,
                        color: Appcolor.primaryColor,
                        size: 20,
                      ),
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                    ),
                  ),
                ),

                Center(
                  child: Text(
                    "Forgot Password",
                    style: getTextStyle(
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.w600,
                      color: Appcolor.primaryColor,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: height * 0.05),

            // Lock Icon Container
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 36),
              decoration: BoxDecoration(
                color: Appcolor.appSecondaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(18),
                      child: Image.asset(Iconpath.lock, fit: BoxFit.contain),
                    ),
                  ),

                  SizedBox(height: 12),
                  Text(
                    "Select which contact details should we use\nto reset your password",
                    textAlign: TextAlign.center,
                    style: getBodyTextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: height * 0.04),
            Text(
              "Forgot Password",
              style: getBodyTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),

            SizedBox(height: 8),

            TextField(
              controller: ctrl.emailController,
              onChanged: ctrl.onTextChanged,
              decoration: InputDecoration(
                hintText: "Enter email or number..",
                hintStyle: getBodyTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                filled: true,
                fillColor: Appcolor.appSecondaryColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: height * 0.04),

            // Continue Button----------->
            CustomButton(buttonText: "Continue", onTap: () {}),
          ],
        ),
      ),
    );
  }
}
