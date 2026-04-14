// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:readytowork/features/employer/job_details/service/job_details_service.dart';

class JobDetailsController extends GetxController {
  final JobDetailsService _service = JobDetailsService();

  // Job data
  var jobDetails = Rxn<Map<String, dynamic>>();
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final jobId = Get.arguments as String?;
    if (jobId != null) {
      fetchJobDetails(jobId);
    }
  }

  /// Fetch job details from API
  Future<void> fetchJobDetails(String jobId) async {
    isLoading.value = true;
    try {
      final response = await _service.getJobDetails(jobId);

      print('Job Details Response: ${response.statusCode}');
      print('Job Details Body: ${response.body}');

      if (response.statusCode == 200 && response.body['success'] == true) {
        jobDetails.value = response.body['data'];
      } else {
        final message =
            response.body['message'] ?? 'Failed to fetch job details';
        Get.snackbar('Error', message, snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      print('Fetch job details error: $e');
      Get.snackbar('Error', 'Failed to fetch job details',
          snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }

  /// Get display status
  String getDisplayStatus(String status) {
    switch (status) {
      case 'open':
        return 'Open';
      case 'assigned':
        return 'Assigned';
      case 'completed':
        return 'Completed';
      case 'cancelled':
        return 'Cancelled';
      case 'closed':
        return 'Closed';
      default:
        return status;
    }
  }

  /// Get status badge color
  Map<String, dynamic> getStatusColor(String status) {
    switch (status) {
      case 'open':
        return {'bg': '0xFFDFF7DF', 'text': '0xFF22863A'};
      case 'assigned':
        return {'bg': '0xFFFFF3CD', 'text': '0xFF856404'};
      case 'completed':
        return {'bg': '0xFFDDE9FF', 'text': '0xFF0366D6'};
      case 'cancelled':
        return {'bg': '0xFFFFE5E5', 'text': '0xFFCB2431'};
      case 'closed':
        return {'bg': '0xFFE8E8E8', 'text': '0xFF586069'};
      default:
        return {'bg': '0xFFE8E8E8', 'text': '0xFF586069'};
    }
  }
}
