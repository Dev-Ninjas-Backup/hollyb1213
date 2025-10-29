import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/routes/app_route.dart';

class VerificationConroller extends GetxController {
  RxList<String> otp = List.filled(4, '').obs;
  RxBool isButtonEnabled = false.obs;
  RxInt secondsRemaining = 60.obs;

  late final TextEditingController digit1;
  late final TextEditingController digit2;
  late final TextEditingController digit3;
  late final TextEditingController digit4;

  @override
  void onInit() {
    super.onInit();
    digit1 = TextEditingController();
    digit2 = TextEditingController();
    digit3 = TextEditingController();
    digit4 = TextEditingController();
    startTimer();
  }

  void updateOTP(int index, String value) {
    otp[index] = value;
    isButtonEnabled.value = !otp.contains('');
  }

  void startTimer() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (secondsRemaining.value > 0) {
        secondsRemaining.value--;
        return true;
      }
      return false;
    });
  }

  void resendCode() {
    secondsRemaining.value = 60;
    startTimer();
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
              SizedBox(
                width: 320,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 10),
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
                            Iconpath.vector2,
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
                        "Verification successful. Your account has\nbeen created and now you can verify\nyour background or visit the app.",
                        style: getBodyTextStyle(fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 30),
                      SizedBox(
                        width: 188,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.toNamed(AppRoute.getuploadProfileScreen());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Appcolor.primaryColor,
                          ),
                          child: Text(
                            'Verify Background',
                            style: getTextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      SizedBox(
                        width: 178,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.offAll(AppRoute.gethomeScreen());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Appcolor.appSecondaryColor,
                          ),
                          child: Text(
                            'Go to Home',
                            style: getTextStyle(
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
            ],
          ),
        ),
        barrierDismissible: false,
      );
    }
  }
}
