import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/features/employee/profile/model/settings_model.dart';

class EmployeeProfileControllre extends GetxController {
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
    ),
    SettingsModel(
      imageUrl: Iconpath.privacy,
      title: "Privacy & privacy",
      subTitle: "Manage your privacy settings",
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
}
