import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/apply_service.dart';
import 'package:hollyb1213/features/employee/jobs/screen/employee_jobs_service.dart';

class JobDetailsController extends GetxController {
  final EmployeeJobsService _service = EmployeeJobsService();
  final ApplyService _applyService = ApplyService();

  var isLoading = true.obs;
  var isApplying = false.obs;
  var jobData = <String, dynamic>{}.obs;
  String? jobId;

  @override
  void onInit() {
    super.onInit();
    jobId = Get.arguments;
    if (jobId != null) {
      getJobDetails(jobId!);
    }
  }

  Future<void> getJobDetails(String id) async {
    isLoading.value = true;
    try {
      final response = await _service.getJobDetails(id);
      if (response.statusCode == 200) {
        final body = response.body;
        if (body['success'] == true) {
          jobData.value = body['data'];
        }
      }
    } catch (e) {
      print('Error fetching job details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> applyJob(String coverNote) async {
    if (jobId == null) return;

    isApplying.value = true;
    try {
      final response = await _applyService.applyJob(
        jobId: jobId!,
        coverNote: coverNote,
      );

      print('Apply Job Response: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.body['success'] == true) {
          Get.snackbar(
            'Success',
            response.body['message'] ??
                'Job application submitted successfully',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          Get.snackbar('Error', response.body['message'] ?? 'Failed to apply',
              snackPosition: SnackPosition.TOP);
        }
      } else {
        Get.snackbar('Error', 'Failed to apply. Please try again.',
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      print('Apply Job Error: $e');
      Get.snackbar('Error', 'Something went wrong',
          snackPosition: SnackPosition.TOP);
    } finally {
      isApplying.value = false;
    }
  }

  String get title => jobData['title'] ?? '';
  String get payRate => "\$${jobData['amount'] ?? '0'}";
  String get company => jobData['company_name'] ?? '';
  String get location => jobData['location'] ?? '';

  String get startDate {
    final date = jobData['job_date'];
    return date != null ? date.toString().split('T')[0] : '';
  }

  String get endDate {
    final date = jobData['expire_date'];
    return date != null ? date.toString().split('T')[0] : '';
  }

  String get workTime =>
      "${jobData['start_time'] ?? ''} - ${jobData['end_time'] ?? ''}";

  String get about => jobData['description'] ?? '';

  List<String> get responsibilities {
    final res = jobData['job_responsibilities'];
    return res != null ? [res.toString()] : [];
  }

  List<String> get requirements {
    final req = jobData['requirements'];
    return req != null ? [req.toString()] : [];
  }

  List<String> get additionalDetails => [];
}
