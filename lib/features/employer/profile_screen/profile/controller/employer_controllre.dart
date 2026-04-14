// ignore_for_file: avoid_print

import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:readytowork/core/common/constants/api_endpoint.dart';

import 'dart:convert';

import 'package:readytowork/core/common/constants/iconpath.dart' show Iconpath;
import 'package:readytowork/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:readytowork/features/auth/login/services/screen/login_screen.dart';
import 'package:readytowork/features/employer/profile_screen/profile/model/employer_profile_model.dart';
import 'package:readytowork/features/employer/profile_screen/profile/model/employer_stats_model.dart';
import 'package:readytowork/features/employer/profile_screen/profile/model/settings_model.dart';
import 'package:readytowork/features/employer/profile_screen/profile/model/subscription_status_model.dart';
import 'package:readytowork/features/employer/profile_screen/profile/service/renew_subscription_service.dart';
import 'package:readytowork/features/employer/profile_screen/profile_info/screen/employer_profile_info_page.dart';
import 'package:readytowork/routes/app_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      ontap: () {
        Get.toNamed(AppRoute.getChangePasswordScreen());
      },
    ),
  ];

  RxList<bool> isSelected = [true, false].obs;
  Rx<EmployerProfileData?> employerProfile = Rx<EmployerProfileData?>(null);
  RxBool isLoadingProfile = false.obs;
  Rx<SubscriptionStatusData?> subscriptionStatus =
      Rx<SubscriptionStatusData?>(null);
  RxBool isLoadingSubscription = false.obs;
  RxBool isRenewingSubscription = false.obs;

  final RenewSubscriptionService _renewService = RenewSubscriptionService();

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
    fetchSubscriptionStatus();
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

      if (accessToken == null) {
        Get.snackbar('Error', 'Access token not found');
        return;
      }

      final response = await http.get(
        Uri.parse(ApiEndpoint.employerProfile),
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

      if (accessToken == null) {
        print('Error: Access token not found');
        return;
      }

      final response = await http.get(
        Uri.parse(ApiEndpoint.employerStats),
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

  Future<void> fetchSubscriptionStatus() async {
    print('[EmployerProfileController] fetchSubscriptionStatus() started');
    try {
      isLoadingSubscription.value = true;
      final accessToken = await SharedPreferenceHelper().getAccessToken();

      if (accessToken == null) {
        print('Error: Access token not found');
        return;
      }

      final response = await http.get(
        Uri.parse(ApiEndpoint.employerSubscriptionStatus),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      print('Subscription Response Status Code: ${response.statusCode}');
      print('Subscription Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print('Parsed Subscription JSON: $jsonResponse');
        final subscriptionResponse =
            SubscriptionStatusResponse.fromJson(jsonResponse);

        if (subscriptionResponse.success) {
          subscriptionStatus.value = subscriptionResponse.data;
          print('Subscription Data: ${subscriptionStatus.value}');
          print(
              'Has Subscription: ${subscriptionStatus.value?.hasSubscription}');
          print(
              'Has Active Subscription: ${subscriptionStatus.value?.hasActiveSubscription}');
          print(
              'Plan Type: ${subscriptionStatus.value?.subscription?.planType}');
        } else {
          print('Error: ${subscriptionResponse.message}');
        }
      } else {
        print(
            'Failed to fetch subscription with status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Exception in fetchSubscriptionStatus: $e');
    } finally {
      isLoadingSubscription.value = false;
    }
  }

  Future<void> handleRenewSubscription() async {
    print('[EmployerProfileController] handleRenewSubscription() started');

    if (subscriptionStatus.value?.subscription == null) {
      Get.snackbar('Error', 'No subscription found to renew');
      return;
    }

    // Navigate to payment screen with renewal context
    Get.toNamed(
      AppRoute.paymentMethodScreen,
      arguments: {
        'isRenewal': true,
        'subscriptionId': subscriptionStatus.value!.subscription!.id,
      },
    );
  }

  Future<void> renewSubscription({
    required String paymentMethodId,
  }) async {
    print('[EmployerProfileController] renewSubscription() started');
    try {
      isRenewingSubscription.value = true;

      final accessToken = await SharedPreferenceHelper().getAccessToken();
      final subscriptionId = subscriptionStatus.value?.subscription?.id;

      if (accessToken == null) {
        Get.snackbar('Error', 'Access token not found');
        return;
      }

      if (subscriptionId == null) {
        Get.snackbar('Error', 'Unable to retrieve subscription details');
        return;
      }

      print('[EmployerProfileController] Calling renewal service');
      final response = await _renewService.renewSubscription(
        accessToken: accessToken,
        subscriptionId: subscriptionId,
        paymentMethodId: paymentMethodId,
      );

      print('Renewal Response Status Code: ${response.statusCode}');
      print('Renewal Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          Get.snackbar(
            'Success',
            'Subscription renewed successfully!',
            snackPosition: SnackPosition.TOP,
            duration: const Duration(seconds: 2),
          );
          // Refresh subscription status
          await Future.delayed(const Duration(seconds: 1));
          await fetchSubscriptionStatus();
        } else {
          final message =
              jsonResponse['message'] ?? 'Failed to renew subscription';
          Get.snackbar('Error', message, snackPosition: SnackPosition.TOP);
        }
      } else {
        final jsonResponse = jsonDecode(response.body);
        final message =
            jsonResponse['message'] ?? 'Failed to renew subscription';
        Get.snackbar('Error', message, snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      print('Exception in renewSubscription: $e');
      Get.snackbar(
        'Error',
        'Error renewing subscription: $e',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isRenewingSubscription.value = false;
    }
  }
}
