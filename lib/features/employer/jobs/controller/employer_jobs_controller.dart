// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:hollyb1213/features/employer/jobs/service/employer_jobs_service.dart';
import 'package:hollyb1213/core/common/constants/api_endpoint.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EmployerJobsController extends GetxController {
  final EmployerJobsService _service = EmployerJobsService();

  // Status filter
  var selectedCategory = 'open'.obs;
  var isUrgentFilter = false.obs;
  var allJobs = <Map<String, dynamic>>[].obs;
  var filteredJobs = <Map<String, dynamic>>[].obs;
  var isFavoritedMap = <String, RxBool>{}.obs;

  // Pagination
  var currentPage = 1.obs;
  var totalPages = 1.obs;
  var isLoadingMore = false.obs;
  var isLoading = false.obs;

  final int itemsPerPage = 10;

  // Job status mapping
  static const Map<String, String> statusMap = {
    'open': 'open',
    'assigned': 'assigned',
    'completed': 'completed',
    'cancelled': 'cancelled',
    'closed': 'closed',
  };

  @override
  void onInit() {
    super.onInit();
    fetchJobs();
  }

  /// Fetch jobs from API
  Future<void> fetchJobs({bool isRefresh = true}) async {
    if (isRefresh) {
      currentPage.value = 1;
      isLoading.value = true;
      update();
    } else {
      isLoadingMore.value = true;
      update();
    }

    try {
      final status = _mapCategoryToStatus(selectedCategory.value);
      final response = await _service.getPostedJobs(
        status: status,
        isUrgent: isUrgentFilter.value,
        page: currentPage.value,
        limit: itemsPerPage,
      );

      print('Jobs Response: ${response.statusCode}');
      print('Jobs Body: ${response.body}');

      if (response.statusCode == 200 && response.body['success'] == true) {
        final jobsList = List<Map<String, dynamic>>.from(
          response.body['data'] ?? [],
        );

        if (isRefresh) {
          allJobs.clear();
          allJobs.addAll(jobsList);
        } else {
          allJobs.addAll(jobsList);
        }

        // Initialize favorite status for new jobs
        for (var job in jobsList) {
          final jobId = job['id'] as String;
          if (!isFavoritedMap.containsKey(jobId)) {
            isFavoritedMap[jobId] = false.obs;
          }
        }

        final paginationInfo = response.body['paginationInfo'];
        if (paginationInfo != null) {
          totalPages.value = paginationInfo['totalPages'] ?? 1;
        }

        filteredJobs.assignAll(allJobs);
        update();
      } else {
        final message = response.body['message'] ?? 'Failed to fetch jobs';
        Get.snackbar('Error', message, snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      print('Fetch jobs error: $e');
      Get.snackbar('Error', 'Failed to fetch jobs',
          snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
      update();
    }
  }

  /// Load more jobs (pagination)
  Future<void> loadMoreJobs() async {
    if (currentPage.value >= totalPages.value || isLoadingMore.value) return;

    currentPage.value++;
    update();
    await fetchJobs(isRefresh: false);
  }

  /// Filter jobs by category/status
  void setCategory(String category) {
    selectedCategory.value = category;
    currentPage.value = 1;
    allJobs.clear();
    filteredJobs.clear();
    update();
    fetchJobs(isRefresh: true);
  }

  /// Toggle urgent filter
  void toggleUrgentFilter() {
    isUrgentFilter.toggle();
    currentPage.value = 1;
    allJobs.clear();
    filteredJobs.clear();
    update();
    fetchJobs(isRefresh: true);
  }

  /// Toggle favorite status
  void toggleFavourite(String jobId) {
    if (isFavoritedMap.containsKey(jobId)) {
      isFavoritedMap[jobId]!.toggle();
    } else {
      isFavoritedMap[jobId] = true.obs;
    }
    update();
  }

  /// Map category display name to API status
  String _mapCategoryToStatus(String category) {
    return statusMap[category] ?? 'open';
  }

  /// Get display name for status
  String getDisplayStatus(String status) {
    switch (status) {
      case 'open':
        return 'Active';
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

  /// Format job data for UI
  Map<String, dynamic> formatJobForUI(Map<String, dynamic> job) {
    // Handle file which can be null, a string, or a Map with url
    String imageUrl = 'assets/images/job_placeholder.png';
    final file = job['file'];
    if (file != null) {
      if (file is Map) {
        imageUrl = file['url'] ?? 'assets/images/job_placeholder.png';
      } else if (file is String) {
        imageUrl = file;
      }
    }

    return {
      'id': job['id'],
      'image': imageUrl,
      'title': job['title'] ?? 'Untitled Job',
      'subtitle': job['location'] ?? 'Location not specified',
      'distance': job['company_name'] ?? 'Company',
      'urgent': job['is_urgent'] ?? false,
      'status': job['status'] ?? 'open',
      'amount': job['amount'] ?? '0',
      'applicants': job['_count']?['job_applications'] ?? 0,
      'startTime': job['start_time'] ?? '',
      'endTime': job['end_time'] ?? '',
      'jobDate': job['job_date'] ?? '',
      'expireDate': job['expire_date'] ?? '',
      'isFavourite': isFavoritedMap[job['id']] ?? false.obs,
    };
  }

  /// Add employee as favorite
  Future<void> addEmployeeAsFavorite(String employeeId) async {
    try {
      final accessToken = await SharedPreferenceHelper().getAccessToken();
      if (accessToken == null) {
        Get.snackbar('Error', 'Access token not found');
        return;
      }

      final response = await http.post(
        Uri.parse(ApiEndpoint.addEmployeeAsFavorite),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'employee_id': employeeId,
        }),
      );

      print('Add Favorite Response: ${response.statusCode}');
      print('Add Favorite Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar('Success', 'Employee added to favorites');
      } else {
        final jsonResponse = jsonDecode(response.body);
        final message = jsonResponse['message'] ?? 'Failed to add to favorites';
        Get.snackbar('Error', message);
      }
    } catch (e) {
      print('Error adding favorite: $e');
      Get.snackbar('Error', 'Error: $e');
    }
  }

  /// Check if employee is already added as favorite
  Future<bool> checkIfEmployeeFavorite(String employeeId) async {
    try {
      final accessToken = await SharedPreferenceHelper().getAccessToken();
      if (accessToken == null) {
        return false;
      }

      final response = await http.get(
        Uri.parse(ApiEndpoint.checkEmployeeIfFavorite(employeeId)),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      print('Check Favorite Response: ${response.statusCode}');
      print('Check Favorite Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        return jsonResponse['data']?['isFavorite'] ?? false;
      }
      return false;
    } catch (e) {
      print('Error checking favorite: $e');
      return false;
    }
  }
}
