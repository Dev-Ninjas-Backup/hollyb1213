import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readytowork/features/employee/employee_applied_jobs/employee_applied_jobs_service.dart';

class EmployeeAppliedJobsController extends GetxController {
  final EmployeeAppliedJobsService _service = EmployeeAppliedJobsService();
  var isLoading = false.obs;
  final RxList<Map<String, dynamic>> appliedJobsList =
      <Map<String, dynamic>>[].obs;
  var selectedTab = 0.obs;

  // --- Reactive Getters for Filtered Lists ---
  List<Map<String, dynamic>> get activeJobs => appliedJobsList.where((job) {
        final status = (job['status'] as String?)?.toLowerCase();
        return status != 'completed' && status != 'paid';
      }).toList();

  List<Map<String, dynamic>> get completedJobs => appliedJobsList.where((job) {
        final status = (job['status'] as String?)?.toLowerCase();
        return status == 'completed' || status == 'paid';
      }).toList();

  @override
  void onInit() {
    super.onInit();
    // Fetch jobs when the controller is initialized.
    getAppliedJobs();
  }

  Future<void> getAppliedJobs() async {
    isLoading.value = true;
    try {
      final response = await _service.getAppliedJobs();
      if (response.statusCode == 200 && response.body['success'] == true) {
        final List<dynamic> rawData = response.body['data'] ?? [];
        final List<Map<String, dynamic>> processedData = rawData.map((item) {
          final job = item['job'] as Map<String, dynamic>? ?? {};
          return {
            ...job,
            'application_id': item['application_id'],
            'application_status': item['application_status'],
            'cover_note': item['cover_note'],
            'applied_at': item['applied_at'],
            'updated_at': item['updated_at'],
          };
        }).toList();
        appliedJobsList.assignAll(processedData);
      } else {
        Get.snackbar(
          'Error',
          response.body?['message'] ?? 'Failed to fetch applied jobs.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        print('Failed to fetch applied jobs: ${response.statusText}');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print('Error fetching applied jobs: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
