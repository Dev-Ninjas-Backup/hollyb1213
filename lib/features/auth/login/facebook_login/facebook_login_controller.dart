/*
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'facebook_login_services.dart';

class LoginController extends GetxController {
  var emailOrPhone = ''.obs;
  var password = ''.obs;
  var isPasswordVisible = false.obs;
  var rememberMe = false.obs;
  var isLoading = false.obs;

  // Facebook User Data
  var facebookUserData = {}.obs;
  var isFacebookLoggedIn = false.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    checkFacebookLoginStatus();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

  // Facebook Login Status Check
  Future<void> checkFacebookLoginStatus() async {
    final loggedIn = await FacebookLoginServices.isLoggedIn();
    if (loggedIn) {
      final data = await FacebookLoginServices.getUserData();
      if (data != null) {
        facebookUserData.value = data;
        isFacebookLoggedIn.value = true;
      }
    }
  }

  // Facebook Login
  Future<void> loginWithFacebook() async {
    isLoading.value = true;

    final data = await FacebookLoginServices.loginWithFacebook();

    if (data != null) {
      facebookUserData.value = data;
      isFacebookLoggedIn.value = true;

      Get.snackbar(
        'Success',
        'Welcome ${data['name']}!',
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.snackbar(
        ' Failed',
        'Facebook Login Failed. Try again!',
        snackPosition: SnackPosition.BOTTOM,
      );
    }

    isLoading.value = false;
  }

  // Facebook Logout
  Future<void> logoutFacebook() async {
    await FacebookLoginServices.logoutFromFacebook();
    facebookUserData.value = {};
    isFacebookLoggedIn.value = false;
  }
}
*/
