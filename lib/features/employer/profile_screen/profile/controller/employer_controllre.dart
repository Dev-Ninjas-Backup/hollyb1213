import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/features/employee/profile_screen/profile/model/settings_model.dart';
import 'package:hollyb1213/features/auth/role_selection/screen/role_selection_screen.dart';
import 'package:hollyb1213/features/employer/profile_screen/profile_info/screen/employer_profile_info_page.dart';
import 'package:hollyb1213/routes/app_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployerProfileController extends GetxController {
  final List<Map<String, dynamic>> statsList = [
    {
      "iconImage": Iconpath.jobProfileIcon,
      "count": "6",
      "completedMsg": "Active Jobs",
    },
    {
      "iconImage": "assets/icons/checkmark.png",
      "count": "20",
      "completedMsg": "Completed Jobs",
    },
    {
      "iconImage": Iconpath.favourite,
      "count": "10",
      "completedMsg": "Favorite Workers",
    },
    {
      "iconImage": Iconpath.dualPerson,
      "count": "40",
      "completedMsg": "Total Hires",
    },
  ];

  final List<SettingsModel> settingsitems = [
    SettingsModel(
      imageUrl: Iconpath.profile2,
      title: "Profile Info",
      subTitle: "Update your name, email, or phone number",
      ontap: () {
        Get.to(EmployerProfileInfoPage());
      },
    ),
    SettingsModel(
        imageUrl: Iconpath.privacy,
        title: "Privacy & Policy",
        subTitle: "Manage your privacy settings",
        ontap: () {
          Get.toNamed(AppRoute.employeeprivacy);
        }),
    SettingsModel(
      imageUrl: Iconpath.document,
      title: "Documents",
      subTitle: "ID verification and certificates",
    ),
    SettingsModel(
      imageUrl: Iconpath.support,
      title: "Help & Support",
      subTitle: "Get help or contact support",
    ),
    SettingsModel(
      imageUrl: Iconpath.about,
      title: "About Us",
      subTitle: "Get help or contact support",
    ),
    SettingsModel(
      imageUrl: Iconpath.changepassword,
      title: "Change Password",
      subTitle: "Update your login password for security",
    ),
  ];

  RxList<bool> isSelected = [true, false].obs;

  @override
  void onInit() {
    super.onInit();
    loadPreference();
  }

  Future<void> loadPreference() async {
    final prefs = await SharedPreferences.getInstance();
    bool enabled = prefs.getBool('notificationsEnabled') ?? true;
    isSelected.value = enabled ? [true, false] : [false, true];
  }

  Future<void> toggle(int index) async {
    for (int i = 0; i < isSelected.length; i++) {
      isSelected[i] = i == index;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', index == 0);
  }

  Future<void> signOut() async {
    // Sign out from Facebook
    await FacebookAuth.instance.logOut();
    // Clear any local user data (e.g., from SharedPreferences)
    final prefs = await SharedPreferences.getInstance();
    await prefs
        .clear(); // Clears all data, be careful if you store other things
    Get.offAll(() => RoleSelectionScreen());
  }
}
