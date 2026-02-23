import 'package:flutter/widgets.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/features/auth/role_selection/controller/role_selection_controller.dart';
import 'package:hollyb1213/routes/app_route.dart';

class LoginController extends GetxController {
  var emailOrPhone = ''.obs;
  var password = ''.obs;
  var isPasswordVisible = false.obs;
  var rememberMe = false.obs;
  var isLoading = false.obs;

  // To store Facebook user data
  var facebookUserData = {}.obs;
  var isFacebookLoggedIn = false.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Access RoleSelectionController to determine navigation path
  RoleSelectionController get role => Get.find<RoleSelectionController>();

  @override
  void onInit() {
    super.onInit();
    checkFacebookLoginStatus();
  }

  // Check if user is already logged in with Facebook
  Future<void> checkFacebookLoginStatus() async {
    final accessToken = await FacebookAuth.instance.accessToken;
    if (accessToken != null) {
      final userData = await FacebookAuth.instance.getUserData(
        fields: "name,email,picture.width(200)",
      );
      facebookUserData.value = userData;
      isFacebookLoggedIn.value = true;
      // Optionally, you can navigate the user directly to the home screen here
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
  }

  Future<void> loginWithFacebook() async {
    try {
      isLoading.value = true;
      // Request specific permissions for email and profile
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      if (result.status == LoginStatus.success) {
        // Get user data if login is successful
        final userData = await FacebookAuth.instance.getUserData(
          fields: "name,email,picture.width(200)",
        );
        facebookUserData.value = userData;

        Get.snackbar('Success', 'Welcome ${userData['name']}!');

        // Navigate to the correct screen based on the selected role, and clear previous screens
        if (role.selectedRole.value == "employee") {
          Get.offAllNamed(AppRoute.getEmployeeBottomNavbarScreen());
        } else {
          Get.offAllNamed(AppRoute.getemployerBottomNavbarScreen());
        }
      } else {
        Get.snackbar('Login Failed',
            result.message ?? 'Facebook login was cancelled or failed.');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  // Facebook Logout
  Future<void> logoutFacebook() async {
    await FacebookAuth.instance.logOut();
    facebookUserData.value = {};
    isFacebookLoggedIn.value = false;
  }
}
