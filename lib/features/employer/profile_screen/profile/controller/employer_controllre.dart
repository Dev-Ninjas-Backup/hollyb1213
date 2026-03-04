import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:hollyb1213/features/auth/login/services/screen/login_screen.dart';
import 'package:hollyb1213/features/employee/profile_screen/profile/model/settings_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hollyb1213/features/auth/role_selection/screen/role_selection_screen.dart';
import 'package:hollyb1213/features/employer/profile_screen/profile_info/screen/employer_profile_info_page.dart';
import 'package:hollyb1213/routes/app_route.dart';
import 'package:hollyb1213/features/employer/profile_screen/profile/model/employer_profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:hollyb1213/core/common/constants/api_endpoint.dart';
import 'package:hollyb1213/features/employer/profile_screen/profile/model/employer_stats_model.dart';
import 'dart:convert';

class EmployerProfileController extends GetxController {
  final List<Map<String, dynamic>> initialStatsList = [
    {
      "iconImage": Iconpath.jobProfileIcon,
      "count": "0",
      "completedMsg": "Active Jobs",
    },
    {
      "iconImage": "assets/icons/checkmark.png",
      "count": "0",
      "completedMsg": "Completed Jobs",
    },
    {
      "iconImage": Iconpath.favourite,
      "count": "0",
      "completedMsg": "Favorite Workers",
    },
    {
      "iconImage": Iconpath.dualPerson,
      "count": "0",
      "completedMsg": "Total Hires",
    },
  ];

  RxList<Map<String, dynamic>> statsList = <Map<String, dynamic>>[].obs;
  Rx<EmployerStatsData?> employerStats = Rx<EmployerStatsData?>(null);
  RxBool isLoadingStats = false.obs;

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
  Rx<EmployerProfileData?> employerProfile = Rx<EmployerProfileData?>(null);
  RxBool isLoadingProfile = false.obs;

  EmployerProfileController() {
    print('[EmployerProfileController] Constructor called');
  }

  @override
  void onInit() {
    print('[EmployerProfileController] onInit() called');
    super.onInit();
    loadPreference();
    fetchEmployerProfile();
    fetchEmployerStats();
    // Initialize with default values
    statsList.value = List.from(initialStatsList);
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

  Future<void> fetchEmployerProfile() async {
    print('[EmployerProfileController] fetchEmployerProfile() started');
    try {
      isLoadingProfile.value = true;
      final accessToken = await SharedPreferenceHelper().getAccessToken();
      print('[EmployerProfileController] Access Token: $accessToken');

      if (accessToken == null) {
        Get.snackbar('Error', 'Access token not found');
        return;
      }

      final response = await http.get(
        Uri.parse(ApiEndpoint.baseUrl + ApiEndpoint.employerProfile),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print('Parsed JSON: $jsonResponse');
        final profileResponse = EmployerProfileResponse.fromJson(jsonResponse);

        if (profileResponse.success) {
          employerProfile.value = profileResponse.data;
          print('Profile Data: ${employerProfile.value}');
          print('Profile Name: ${employerProfile.value?.fullName}');
        } else {
          print('Error: ${profileResponse.message}');
          Get.snackbar('Error', profileResponse.message);
        }
      } else {
        print('Failed with status code: ${response.statusCode}');
        Get.snackbar('Error', 'Failed to fetch profile');
      }
    } catch (e) {
      print('Exception: $e');
      Get.snackbar('Error', 'Error fetching profile: $e');
    } finally {
      isLoadingProfile.value = false;
    }
  }

  Future<void> signOut() async {
    // Sign out from Facebook
    await FacebookAuth.instance.logOut();
    // Clear any local user data (e.g., from SharedPreferences)
    final preferenceHelper = SharedPreferenceHelper();
    await preferenceHelper.clearAll();
    Get.offAll(() => LoginScreen());
  }

  Future<void> fetchEmployerStats() async {
    print('[EmployerProfileController] fetchEmployerStats() started');
    try {
      isLoadingStats.value = true;
      final accessToken = await SharedPreferenceHelper().getAccessToken();
      print('[EmployerProfileController] Access Token for Stats: $accessToken');

      if (accessToken == null) {
        print('Error: Access token not found');
        return;
      }

      final response = await http.get(
        Uri.parse(ApiEndpoint.baseUrl + ApiEndpoint.employerStats),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      print('Stats Response Status Code: ${response.statusCode}');
      print('Stats Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print('Parsed Stats JSON: $jsonResponse');
        final statsResponse = EmployerStatsResponse.fromJson(jsonResponse);

        if (statsResponse.success) {
          employerStats.value = statsResponse.data;
          print('Stats Data: ${employerStats.value}');
          print('Active Jobs: ${employerStats.value?.activeJobs}');
          print('Completed Jobs: ${employerStats.value?.completedJobs}');
          print('Favorite Workers: ${employerStats.value?.favoriteWorkers}');
          print('Total Hires: ${employerStats.value?.totalHires}');

          // Update statsList with actual data
          statsList.value = [
            {
              "iconImage": Iconpath.jobProfileIcon,
              "count": employerStats.value?.activeJobs.toString() ?? "0",
              "completedMsg": "Active Jobs",
            },
            {
              "iconImage": "assets/icons/checkmark.png",
              "count": employerStats.value?.completedJobs.toString() ?? "0",
              "completedMsg": "Completed Jobs",
            },
            {
              "iconImage": Iconpath.favourite,
              "count": employerStats.value?.favoriteWorkers.toString() ?? "0",
              "completedMsg": "Favorite Workers",
            },
            {
              "iconImage": Iconpath.dualPerson,
              "count": employerStats.value?.totalHires.toString() ?? "0",
              "completedMsg": "Total Hires",
            },
          ];
        } else {
          print('Error: ${statsResponse.message}');
        }
      } else {
        print('Failed to fetch stats with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception in fetchEmployerStats: $e');
    } finally {
      isLoadingStats.value = false;
    }
  }
}
