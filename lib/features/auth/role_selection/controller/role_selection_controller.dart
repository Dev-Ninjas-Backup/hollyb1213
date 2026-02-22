// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:hollyb1213/routes/app_route.dart';

class RoleSelectionController extends GetxController {
  final SharedPreferenceHelper _prefs = SharedPreferenceHelper();

  var selectedRole = ''.obs;
  var isLoading = false.obs;

  void selectRole(String role) {
    selectedRole.value = role;
    print('Role Selected: $role');
  }

  bool get isRoleSelected => selectedRole.isNotEmpty;

  Future<void> goToLogin() async {
    if (!isRoleSelected) {
      Get.snackbar(
        'Select Role',
        'Please select a role to continue',
        snackPosition: SnackPosition.TOP,
      );
      return;
    }

    isLoading.value = true;

    await _prefs.saveSelectedRole(selectedRole.value);
    print('Role saved to SharedPrefs: ${selectedRole.value}');

    isLoading.value = false;

    Get.toNamed(AppRoute.getloginScreen());
  }
}
