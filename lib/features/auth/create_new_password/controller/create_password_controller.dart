import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/core/common/constants/widget/custom_button.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/routes/app_route.dart';

class CreatePasswordController extends GetxController {
  var password = ''.obs;
  var confirmPassword = ''.obs;
  var isPasswordVisible = false.obs;
  var isConfirmVisible = false.obs;

  // Reactive bool for button enable
  var isButtonEnabled = false.obs;

  @override
  void onInit() {
    super.onInit();
    everAll([password, confirmPassword], (_) {
      isButtonEnabled.value =
          password.value.isNotEmpty &&
          confirmPassword.value.isNotEmpty &&
          password.value == confirmPassword.value;
    });
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmVisibility() {
    isConfirmVisible.value = !isConfirmVisible.value;
  }

  void continueAction() {
    if (isButtonEnabled.value) {
      Get.dialog(
        Dialog(
          backgroundColor: Appcolor.backgroundcolor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            children: [
              // Main dialog content
              SizedBox(
                width: 260,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        height: 90,
                        width: 90,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Appcolor.primaryColor,
                            width: 30,
                          ),
                        ),
                        child: Center(
                          child: Image.asset(
                            Iconpath.vector,
                            height: 13,
                            width: 14,
                            color: Appcolor.primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "Congratulations!",
                        style: getTextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Your account is ready to use",
                        style: getBodyTextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      CustomButton(
                        buttonText: "Continue",
                        onTap: () {
                          Get.offAllNamed(AppRoute.getloginScreen());
                        },
                      ),
                    ],
                  ),
                ),
              ),

              Positioned(
                right: 10,
                top: 8,
                child: GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Icon(Icons.close, size: 18, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
        barrierDismissible: false,
      );
    }
  }
}
