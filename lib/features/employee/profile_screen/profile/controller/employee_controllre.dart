import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/features/employee/profile_screen/profile/model/settings_model.dart';
import 'package:hollyb1213/routes/app_route.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeProfileControllerLegacy extends GetxController {
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> logout() async {
    final SharedPreferenceHelper prefs = SharedPreferenceHelper();
    await prefs.clearAll();
    Get.offAllNamed(AppRoute.getloginScreen());
  }
}
