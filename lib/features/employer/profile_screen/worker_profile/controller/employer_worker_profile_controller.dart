import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:readytowork/core/common/constants/api_endpoint.dart';
import 'package:readytowork/core/common/share_preferrance/share_preferrance_helper.dart';
import 'dart:convert';

import 'package:readytowork/features/employer/profile_screen/worker_profile/model/employee_profile_model.dart';

class EmployerWorkerProfileController extends GetxController {
  final employeeProfile = Rx<EmployeeProfileData?>(null);
  final isLoading = true.obs;
  final error = ''.obs;

  Future<void> fetchEmployeeProfile(String employeeId) async {
    try {
      isLoading.value = true;
      error.value = '';

      final accessToken = await SharedPreferenceHelper().getAccessToken();
      if (accessToken == null) {
        error.value = 'Access token not found';
        Get.snackbar('Error', 'Access token not found');
        return;
      }

      final response = await http.get(
        Uri.parse(ApiEndpoint.viewEmployeeProfile(employeeId)),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          employeeProfile.value =
              EmployeeProfileData.fromJson(jsonResponse['data']);
        } else {
          error.value = jsonResponse['message'] ?? 'Failed to fetch profile';
          Get.snackbar('Error', error.value);
        }
      } else {
        error.value = 'Failed to load employee profile';
        Get.snackbar('Error', error.value);
      }
    } catch (e) {
      error.value = 'Error: $e';
      Get.snackbar('Error', 'Error loading profile: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
