import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readytowork/core/common/constants/appcolor.dart';
import 'package:readytowork/core/common/constants/iconpath.dart';
import 'package:readytowork/core/common/style/global_text_style.dart';
import 'package:readytowork/routes/app_route.dart';


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
                width: 307,
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
                      SizedBox(height: 20),
                      Text(
                        "Congratulations!",
                        style: getTextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Your account is ready to use",
                        style: getBodyTextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),
                      SizedBox(
                        width: 188,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.toNamed(AppRoute.getroleSelection());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Appcolor.primaryColor,
                          ),
                          child: Text(
                            'Continue',
                            style: getTextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
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
