import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/api_endpoint.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:hollyb1213/features/employer/applicants/model/job_applicant_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ViewApplicantsController extends GetxController {
  // Jobs list
  var allJobs = <JobApplicantModel>[].obs;
  var isLoadingJobs = false.obs;
  var isLoadingMoreJobs = false.obs;

  // Pagination
  var currentPage = 1.obs;
  var totalPages = 1.obs;
  final int itemsPerPage = 10;

  // Applicants
  var jobApplicants = <String, List<Map<String, dynamic>>>{}.obs;
  var loadingApplicantsFor = <String>{}.obs;

  // Search
  var searchQuery = ''.obs;

  // Expanded jobs
  var expandedJobIds = <String>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllJobs();
  }

  /// Fetch all jobs with pagination
  Future<void> fetchAllJobs({bool isRefresh = true}) async {
    try {
      if (isRefresh) {
        currentPage.value = 1;
        isLoadingJobs.value = true;
      } else {
        isLoadingMoreJobs.value = true;
      }

      final accessToken = await SharedPreferenceHelper().getAccessToken();
      if (accessToken == null) {
        Get.snackbar('Error', 'Access token not found');
        return;
      }

      final response = await http.get(
        Uri.parse(
          ApiEndpoint.getAllJobs2(currentPage.value, itemsPerPage),
        ),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      print('Fetch Jobs Response: ${response.statusCode}');
      print('Fetch Jobs Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          final List<dynamic> jobsList = jsonResponse['data'] ?? [];

          final jobs = jobsList
              .map((jobJson) =>
                  JobApplicantModel.fromJson(jobJson as Map<String, dynamic>))
              .toList();

          if (isRefresh) {
            allJobs.clear();
            allJobs.addAll(jobs);
          } else {
            allJobs.addAll(jobs);
          }

          final paginationInfo = jsonResponse['paginationInfo'];
          if (paginationInfo != null) {
            totalPages.value = paginationInfo['totalPages'] ?? 1;
          }

          print('Jobs Loaded: ${allJobs.length}');
        }
      } else {
        Get.snackbar('Error', 'Failed to load jobs');
      }
    } catch (e) {
      print('Fetch jobs error: $e');
      Get.snackbar('Error', 'Error loading jobs: $e');
    } finally {
      isLoadingJobs.value = false;
      isLoadingMoreJobs.value = false;
    }
  }

  /// Load more jobs (pagination)
  Future<void> loadMoreJobs() async {
    if (currentPage.value >= totalPages.value || isLoadingMoreJobs.value) {
      return;
    }
    currentPage.value++;
    await fetchAllJobs(isRefresh: false);
  }

  /// Fetch applicants for a specific job
  Future<void> fetchApplicantsForJob(String jobId) async {
    try {
      // If already loaded, don't fetch again
      if (jobApplicants.containsKey(jobId)) {
        return;
      }

      loadingApplicantsFor.add(jobId);

      final accessToken = await SharedPreferenceHelper().getAccessToken();
      if (accessToken == null) {
        Get.snackbar('Error', 'Access token not found');
        return;
      }

      final response = await http.get(
        Uri.parse(ApiEndpoint.viewAllApplicationts(jobId)),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      print('Fetch Applicants Response: ${response.statusCode}');
      print('Fetch Applicants Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          final List<dynamic> applicationsList =
              jsonResponse['data']['applications'] ?? [];

          // Filter to only show applications with 'applied' status
          final filteredApplications = applicationsList
              .where(
                  (app) => (app as Map<String, dynamic>)['status'] == 'applied')
              .toList();

          jobApplicants[jobId] =
              filteredApplications.cast<Map<String, dynamic>>();

          print(
              'Applicants Loaded for job $jobId: ${jobApplicants[jobId]?.length}');
        }
      } else {
        Get.snackbar('Error', 'Failed to load applicants');
      }
    } catch (e) {
      print('Fetch applicants error: $e');
      Get.snackbar('Error', 'Error loading applicants: $e');
    } finally {
      loadingApplicantsFor.remove(jobId);
    }
  }

  /// Toggle job expansion
  Future<void> toggleJobExpansion(String jobId) async {
    if (expandedJobIds.contains(jobId)) {
      expandedJobIds.remove(jobId);
    } else {
      expandedJobIds.add(jobId);
      // Fetch applicants when expanded
      await fetchApplicantsForJob(jobId);
    }
  }

  /// Get filtered jobs based on search query
  List<JobApplicantModel> getFilteredJobs() {
    if (searchQuery.isEmpty) {
      return allJobs.toList();
    }

    final query = searchQuery.value.toLowerCase();
    return allJobs
        .where((job) => job.title.toLowerCase().contains(query))
        .toList();
  }

  /// Get applicants for a job
  List<Map<String, dynamic>> getApplicantsForJob(String jobId) {
    return jobApplicants[jobId] ?? [];
  }

  /// Remove applicant from the list (after accept/reject)
  void removeApplicantFromUI(String jobId, String applicationId) {
    if (jobApplicants.containsKey(jobId)) {
      jobApplicants[jobId]?.removeWhere((app) => app['id'] == applicationId);
      jobApplicants.refresh(); // Trigger UI rebuild
    }
  }

  /// Accept applicant
  Future<void> acceptApplicant(String applicationId, {String? jobId}) async {
    try {
      final accessToken = await SharedPreferenceHelper().getAccessToken();
      if (accessToken == null) {
        Get.snackbar('Error', 'Access token not found');
        return;
      }

      final response = await http.post(
        Uri.parse(ApiEndpoint.acceptApplicant(applicationId)),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      print('Accept Applicant Response: ${response.statusCode}');
      print('Accept Applicant Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          Get.snackbar(
            'Success',
            jsonResponse['message'] ?? 'Applicant accepted successfully',
            colorText: Colors.white,
            backgroundColor: Colors.green,
          );
          // Remove applicant from UI immediately
          if (jobId != null) {
            removeApplicantFromUI(jobId, applicationId);
          }
        } else {
          Get.snackbar(
              'Error', jsonResponse['message'] ?? 'Failed to accept applicant');
        }
      } else {
        Get.snackbar('Error',
            'Failed to accept applicant. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Accept applicant error: $e');
      Get.snackbar('Error', 'Error accepting applicant: $e');
    }
  }

  /// Reject applicant
  Future<void> rejectApplicant(String applicationId, {String? jobId}) async {
    try {
      final accessToken = await SharedPreferenceHelper().getAccessToken();
      if (accessToken == null) {
        Get.snackbar('Error', 'Access token not found');
        return;
      }

      final response = await http.post(
        Uri.parse(ApiEndpoint.rejectApplicant(applicationId)),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      print('Reject Applicant Response: ${response.statusCode}');
      print('Reject Applicant Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          Get.snackbar(
            'Success',
            jsonResponse['message'] ?? 'Applicant rejected successfully',
            colorText: Colors.white,
            backgroundColor: Colors.red,
          );
          // Remove applicant from UI immediately
          if (jobId != null) {
            removeApplicantFromUI(jobId, applicationId);
          }
        } else {
          Get.snackbar(
              'Error', jsonResponse['message'] ?? 'Failed to reject applicant');
        }
      } else {
        Get.snackbar('Error',
            'Failed to reject applicant. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Reject applicant error: $e');
      Get.snackbar('Error', 'Error rejecting applicant: $e');
    }
  }
}
