import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readytowork/core/common/constants/appcolor.dart';
import 'package:readytowork/core/common/constants/widget/custom_back_button.dart';
import 'package:readytowork/core/common/constants/widget/custom_button.dart';
import 'package:readytowork/core/common/style/global_text_style.dart';
import 'package:readytowork/features/auth/create_new_password/controller/create_password_controller.dart';


class CreatePasswordScreen extends StatelessWidget {
  CreatePasswordScreen({super.key});

  final CreatePasswordController ctrl = Get.put(CreatePasswordController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Appcolor.backgroundcolor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomBackButton(),
                  ),
                  Text(
                    "Create New Password",
                    style: TextStyle(
                      fontSize: width * 0.05,
                      fontWeight: FontWeight.w600,
                      color: Appcolor.primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50),

              // Password Field
              Text(
                'Create Your New Password',
                style: getBodyTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8),
              Obx(
                () => TextField(
                  onChanged: (val) => ctrl.password.value = val,
                  obscureText: !ctrl.isPasswordVisible.value,
                  decoration: InputDecoration(
                    hintText: '********',
                    prefixIcon: Icon(Icons.lock, color: Colors.grey),
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
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),

              Text(
                'Confirm Your New Password',
                style: getBodyTextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8),
              Obx(
                () => TextField(
                  onChanged: (val) => ctrl.confirmPassword.value = val,
                  obscureText: !ctrl.isConfirmVisible.value,
                  decoration: InputDecoration(
                    hintText: '********',
                    prefixIcon: Icon(Icons.lock, color: Colors.grey),
                    suffixIcon: IconButton(
                      icon: Icon(
                        ctrl.isConfirmVisible.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: ctrl.toggleConfirmVisibility,
                    ),
                    filled: true,
                    fillColor: Appcolor.appSecondaryColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),

              Obx(
                () => CustomButton(
                  buttonText: "Continue",
                  onTap: ctrl.isButtonEnabled.value
                      ? () => ctrl.continueAction()
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
