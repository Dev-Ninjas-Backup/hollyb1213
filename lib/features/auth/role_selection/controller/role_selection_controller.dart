import 'package:get/get.dart';
import 'package:readytowork/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:readytowork/routes/app_route.dart';


class RoleSelectionController extends GetxController {
  var selectedRole = 'employer'.obs;
  var isLoading = false.obs; // For the 'Continue' button
  var isCheckingAuth = true.obs; // For the initial screen loader

  final SharedPreferenceHelper _prefs = SharedPreferenceHelper();

  @override
  void onInit() {
    super.onInit();
    _checkAuthStatus();
  }

  /// Checks for an existing session on app startup.
  /// If a session is found, it navigates to the appropriate dashboard.
  /// Otherwise, it shows the role selection UI.
  Future<void> _checkAuthStatus() async {
    final isLoggedIn = await _prefs.checkLogin();

    if (isLoggedIn) {
      final role = await _prefs.getSelectedRole();
      if (role != null) {
        // User is logged in and has a role, navigate to the dashboard.
        final route = role == 'employee'
            ? AppRoute.getEmployeeBottomNavbarScreen()
            : AppRoute
                .getemployerBottomNavbarScreen(); // Assuming an employer route exists
        Get.offAllNamed(route);
        // Don't set isCheckingAuth to false, as the screen is being replaced.
        return;
      }
    }

    // If not logged in or role is missing, show the role selection UI.
    isCheckingAuth.value = false;
  }

  void selectRole(String role) {
    selectedRole.value = role;
    print('Role Selected: ${selectedRole.value}');
  }

  Future<void> goToLogin() async {
    await _prefs.saveSelectedRole(selectedRole.value);
    print('Role saved to SharedPrefs: ${selectedRole.value}');
    Get.toNamed(AppRoute.getloginScreen());
  }
}
