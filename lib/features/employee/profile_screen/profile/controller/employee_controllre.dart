// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';
import 'package:readytowork/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:readytowork/routes/app_route.dart';

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
