import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OTPController extends GetxController {
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
      await Future.delayed(Duration(seconds: 1));
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
}
