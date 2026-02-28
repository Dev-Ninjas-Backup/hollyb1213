import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/features/employee/profile_screen/profile/model/settings_model.dart';
import 'package:hollyb1213/routes/app_route.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeProfileController extends GetxController {
  final List<Map<String, dynamic>> statsList = [
    {
      "iconImage": Iconpath.jobProfileIcon,
      "count": "40",
      "completedMsg": "Jobs Completed",
    },
    {
      "iconImage": Iconpath.workIcon,
      "count": "120",
      "completedMsg": "Hours Worked",
    },
    {
      "iconImage": Iconpath.earnIcon,
      "count": "\$5.832",
      "completedMsg": "Total Earned",
    },
    {
      "iconImage": Iconpath.monthCalenderIcon,
      "count": "12",
      "completedMsg": "This Month",
    },
  ];

  final List<SettingsModel> settingsitems = [
    SettingsModel(
      imageUrl: Iconpath.profile2,
      title: "Profile Info",
      subTitle: "Update your name, email, or phone number",
      ontap: () {
        Get.toNamed(AppRoute.getemployeeProfileInfo());
      },
    ),
    SettingsModel(
      imageUrl: Iconpath.privacy,
      title: "Privacy & Policy",
      subTitle: "Manage your privacy settings",
      ontap: () {
        Get.toNamed(AppRoute.employeeprivacy);
      },
    ),
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

  RxList<bool> isSelected = [false, true].obs; // Default to "On"

  @override
  void onInit() {
    super.onInit();
    loadPreference();
  }

  Future<void> loadPreference() async {
    final prefs = await SharedPreferences.getInstance();
    bool enabled = prefs.getBool('notificationsEnabled') ?? true;
    isSelected.value = enabled ? [false, true] : [true, false];
  }

  Future<void> toggle(int index) async {
    for (int i = 0; i < isSelected.length; i++) {
      isSelected[i] = i == index;
    }
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', index == 1); // index 1 is "On"
  }

  Future<void> logout() async {
    final SharedPreferenceHelper prefs = SharedPreferenceHelper();
    await prefs.clearAll();
    Get.offAllNamed(AppRoute.getloginScreen());
  }
}
