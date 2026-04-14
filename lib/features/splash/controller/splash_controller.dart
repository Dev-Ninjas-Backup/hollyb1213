import 'package:get/get.dart';
import 'package:readytowork/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:readytowork/routes/app_route.dart';


class SplashController extends GetxController {
  final SharedPreferenceHelper _prefs = SharedPreferenceHelper();

  @override
  void onInit() {
    super.onInit();
    _checkTokenAndNavigate();
  }

  Future<void> _checkTokenAndNavigate() async {
    final accessToken = await _prefs.getAccessToken();
    final role = await _prefs.getSelectedRole();

    // Add a short delay to allow the splash screen to be visible
    await Future.delayed(const Duration(seconds: 2));

    if (accessToken != null && accessToken.isNotEmpty) {
      if (role == 'employee') {
        Get.offAllNamed(AppRoute.getEmployeeBottomNavbarScreen());
      } else {
        Get.offAllNamed(AppRoute.getemployerBottomNavbarScreen());
      }
    } else {
      Get.offAllNamed(AppRoute.getroleSelection());
    }
  }
}
