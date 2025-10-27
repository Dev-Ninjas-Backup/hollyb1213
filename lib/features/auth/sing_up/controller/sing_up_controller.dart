import 'package:get/get.dart';

class SingUpController extends GetxController {
  var name = ''.obs;
  var email = ''.obs;
  var password = ''.obs;
  var confirmPassword = ''.obs;

  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;

  bool get isButtonEnabled =>
      name.isNotEmpty &&
      email.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty &&
      password.value == confirmPassword.value;

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void createAccount() {
    if (isButtonEnabled) {}
  }
}
