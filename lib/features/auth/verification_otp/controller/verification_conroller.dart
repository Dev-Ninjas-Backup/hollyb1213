// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/appcolor.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:hollyb1213/core/common/style/global_text_style.dart';
import 'package:hollyb1213/features/auth/verification_otp/service/verification_service.dart';
import 'package:hollyb1213/routes/app_route.dart';

class VerificationConroller extends GetxController {
  final VerificationService _verificationService = VerificationService();
  final SharedPreferenceHelper _prefs = SharedPreferenceHelper();

  RxList<String> otp = List.filled(6, '').obs;
  RxBool isButtonEnabled = false.obs;
  RxInt secondsRemaining = 60.obs;
  RxBool isLoading = false.obs;

  var email = ''.obs;
  var userId = ''.obs;

  late final TextEditingController digit1;
  late final TextEditingController digit2;
  late final TextEditingController digit3;
  late final TextEditingController digit4;
  late final TextEditingController digit5;
  late final TextEditingController digit6;

  @override
  void onInit() {
    super.onInit();
    digit1 = TextEditingController();
    digit2 = TextEditingController();
    digit3 = TextEditingController();
    digit4 = TextEditingController();
    digit5 = TextEditingController();
    digit6 = TextEditingController();

    final args = Get.arguments;
    if (args != null) {
      email.value = args['email'] ?? '';
      userId.value = args['userId'] ?? '';
      print('Verification — email: ${email.value}, userId: ${userId.value}');
    } else {
      print('No arguments found in VerificationController');
    }

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

  Future<void> resendCode() async {
    if (email.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Email not found.',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    isLoading.value = true;

    try {
      final response = await _verificationService.resendOtp(email: email.value);

      print(
        'Resend OTP — Status: ${response.statusCode}, Body: ${response.body}',
      );

      final body = response.body;
      if (body is! Map) {
        Get.snackbar(
          'Error',
          'Server is unreachable.',
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      if (body['success'] == true || body['success'] == 'true') {
        print('OTP Resent Successfully!');
        secondsRemaining.value = 60;
        startTimer();
        Get.snackbar(
          'Success',
          'OTP resent to ${email.value}',
          snackPosition: SnackPosition.TOP,
        );
      } else {
        final message = body['message'] ?? 'Failed to resend OTP';
        Get.snackbar('Error', message, snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      print('Resend OTP Exception: $e');
      Get.snackbar(
        'Error',
        'Something went wrong.',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> continueAction() async {
    if (!isButtonEnabled.value) return;

    final otpCode = otp.join('');
    print('Email: ${email.value}');
    print('OTP Code: $otpCode');

    if (email.value.isEmpty) {
      Get.snackbar(
        'Error',
        'Email not found. Please try again.',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    isLoading.value = true;

    try {
      final response = await _verificationService.verifyOtp(
        email: email.value,
        code: otpCode,
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

      if (body['success'] == true || body['success'] == 'true') {
        print('OTP Verified Successfully!');

        final accessToken = body['data']['accessToken'];
        final refreshToken = body['data']['refreshToken'];

        final role = await _prefs.getSelectedRole() ?? '';

        await _prefs.saveAuthData(
          accessToken: accessToken,
          refreshToken: refreshToken,
          role: role,
          userId: userId.value.isNotEmpty ? userId.value : null,
        );

        print('Auth saved — role: $role, userId: ${userId.value}');

        isLoading.value = false;

        _showSuccessDialog();
        return;
      } else {
        final message = body['message'] ?? 'OTP verification failed';
        print('API Error: $message');
        Get.snackbar('Error', message, snackPosition: SnackPosition.TOP);
      }
    } catch (e, stackTrace) {
      print('Exception: $e');
      print('StackTrace: $stackTrace');
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
      print('===== DONE =====');
    }
  }

  void _showSuccessDialog() {
    Get.dialog(
      Dialog(
        backgroundColor: Appcolor.backgroundcolor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                          Get.toNamed(AppRoute.getloginScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Appcolor.appSecondaryColor,
                        ),
                        child: Text(
                          'Go to Login',
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

  @override
  void onClose() {
    digit1.dispose();
    digit2.dispose();
    digit3.dispose();
    digit4.dispose();
    digit5.dispose();
    digit6.dispose();
    super.onClose();
  }
}
