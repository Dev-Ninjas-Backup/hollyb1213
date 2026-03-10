// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/api_endpoint.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:hollyb1213/features/employer/completed_job_details/models/completed_job_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CompletedJobDetailsController extends GetxController {
  final String jobId;

  CompletedJobDetailsController({required this.jobId});

  // --- State Variables ---
  final isLoading = true.obs;
  final job = Rxn<CompletedJobModel>();
  final selectedRating = 0.obs;
  final reviewText = ''.obs;
  final isSubmittingReview = false.obs;

  // --- Calculations ---
  String get formattedJobDate {
    if (job.value?.jobDate == null) return 'N/A';
    try {
      final date = DateTime.parse(job.value!.jobDate);
      return '${_getMonthName(date.month)} ${date.day}, ${date.year}';
    } catch (e) {
      return job.value?.jobDate ?? 'N/A';
    }
  }

  String get startDate {
    if (job.value?.jobDate == null) return 'N/A';
    try {
      final date = DateTime.parse(job.value!.jobDate);
      return '${_getMonthName(date.month)} ${date.day}, ${date.year}';
    } catch (e) {
      return 'N/A';
    }
  }

  String get endDate {
    if (job.value?.expireDate == null) return 'N/A';
    try {
      final date = DateTime.parse(job.value!.expireDate);
      return '${_getMonthName(date.month)} ${date.day}, ${date.year}';
    } catch (e) {
      return 'N/A';
    }
  }

  String get timeRange {
    if (job.value?.startTime == null || job.value?.endTime == null) {
      return 'N/A';
    }
    return 'Time: ${job.value!.startTime} - ${job.value!.endTime}';
  }

  String get totalEarnings {
    if (job.value?.totalAmount == null) return '\$0';
    try {
      final amount = int.parse(job.value!.totalAmount);
      return '\$${amount.toString()}';
    } catch (e) {
      return '\$${job.value!.totalAmount}';
    }
  }

  String get totalHoursWorked {
    if (job.value?.shifts == null || job.value!.shifts.isEmpty) {
      return '0h 0m 0s';
    }
    try {
      int totalSeconds = 0;
      for (final shift in job.value!.shifts) {
        totalSeconds += shift.totalWorkedSeconds;
      }

      final hours = totalSeconds ~/ 3600;
      final minutes = (totalSeconds % 3600) ~/ 60;
      final seconds = totalSeconds % 60;

      return '${hours}h ${minutes}m ${seconds}s';
    } catch (e) {
      return 'N/A';
    }
  }

  @override
  void onInit() {
    super.onInit();
    _fetchJobDetails();
  }

  /// Fetch completed job details from API
  Future<void> _fetchJobDetails() async {
    try {
      isLoading.value = true;
      final accessToken = await SharedPreferenceHelper().getAccessToken();

      if (accessToken == null) {
        Get.snackbar('Error', 'Access token not found');
        return;
      }

      final response = await http.get(
        Uri.parse(
          ApiEndpoint.baseUrl + ApiEndpoint.getJobDetails(jobId),
        ),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      print('Completed Job Details Response Status: ${response.statusCode}');
      print('Completed Job Details Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          final jobData = jsonResponse['data'];
          job.value = CompletedJobModel.fromJson(jobData);
          print('Job Details Loaded: ${job.value?.title}');
        }
      } else {
        print('Failed to fetch job details: ${response.statusCode}');
        Get.snackbar('Error', 'Failed to load job details');
      }
    } catch (e) {
      print('Exception in _fetchJobDetails: $e');
      Get.snackbar('Error', 'Error loading job details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  /// Update selected rating
  void setRating(int rating) {
    selectedRating.value = rating;
  }

  /// Submit review
  Future<void> submitReview() async {
    if (selectedRating.value == 0) {
      Get.snackbar('Warning', 'Please select a rating');
      return;
    }

    try {
      isSubmittingReview.value = true;

      final accessToken = await SharedPreferenceHelper().getAccessToken();
      if (accessToken == null) {
        Get.snackbar('Error', 'Access token not found');
        return;
      }

      final response = await http.post(
        Uri.parse(ApiEndpoint.rateJob(jobId)),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'rating': selectedRating.value.toDouble(),
          'comment': reviewText.value,
        }),
      );

      print('Submit Review Response Status: ${response.statusCode}');
      print('Submit Review Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          Get.back();
          Get.snackbar(
            'Success',
            'Your review has been submitted successfully',
            duration: Duration(seconds: 2),
          );

          // Reset form
          selectedRating.value = 0;
          reviewText.value = '';
        }
      } else {
        final jsonResponse = jsonDecode(response.body);
        final message = jsonResponse['message'] ?? 'Failed to submit review';
        Get.snackbar('Error', message);
      }
    } catch (e) {
      print('Error submitting review: $e');
      Get.snackbar('Error', 'Failed to submit review: $e');
    } finally {
      isSubmittingReview.value = false;
    }
  }

  String _getMonthName(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return months[month - 1];
  }
}
