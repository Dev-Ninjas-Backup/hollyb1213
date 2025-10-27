import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  var isButtonEnabled = false.obs;

  void onTextChanged(String value) {
    isButtonEnabled.value = value.trim().isNotEmpty;
  }
}
