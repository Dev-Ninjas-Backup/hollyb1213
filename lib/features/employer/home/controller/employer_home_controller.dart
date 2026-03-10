// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/core/common/constants/api_endpoint.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:hollyb1213/features/employer/jobs/models/job_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EmployerHomeController extends GetxController {
  // Header (untouched)
  final headerTitle = "Need a Worker Today ?".obs;
  final headerSubtitle =
      "Post your job and find verified workers instantly.".obs;

  // Quick Actions (untouched)
  final quickActions = <Map<String, dynamic>>[
    {
      "icon": Iconpath.applicants,
      "title": "View Applicants",
      "subtitle": "",
      "height": 40.0,
      "width": 40.0,
    },
    {
      "icon": Iconpath.favourite,
      "title": "Favourite Workers",
      "subtitle": "",
      "height": 40.0,
      "width": 40.0,
    },
  ].obs;

  // --- Category Tabs ---
  final selectedCategory = 'Active'.obs;

  // --- Job Lists ---
  final activeJobs = <JobModel>[].obs;
  final completedJobs = <JobModel>[].obs;

  // --- Store favourite jobs separately ---
  final favouriteJobIds = <String>{}.obs;

  // --- Loading States ---
  final isLoadingActiveJobs = false.obs;
  final isLoadingCompletedJobs = false.obs;

  // --- Toggle between Active and Completed ---
  void setCategory(String category) {
    selectedCategory.value = category;
    if (category == 'Active') {
      _fetchActiveJobs();
    } else if (category == 'Completed') {
      _fetchCompletedJobs();
    }
  }

  // --- Get filtered job list ---
  RxList<JobModel> get filteredJobs =>
      selectedCategory.value == 'Active' ? activeJobs : completedJobs;

  @override
  void onInit() {
    super.onInit();
    print('[EmployerHomeController] onInit called');
    _fetchActiveJobs();
  }

  /// Fetch jobs with status 'open' (for Active tab)
  Future<void> _fetchActiveJobs() async {
    print('[EmployerHomeController] _fetchActiveJobs() started');
    try {
      isLoadingActiveJobs.value = true;
      final accessToken = await SharedPreferenceHelper().getAccessToken();

      if (accessToken == null) {
        Get.snackbar('Error', 'Access token not found');
        return;
      }

      final response = await http.get(
        Uri.parse(
          ApiEndpoint.baseUrl +
              ApiEndpoint.getMyPostedJobsHomeScreen('open', 1, 10)
                  .replaceFirst(ApiEndpoint.baseUrl, ''),
        ),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      print('Active Jobs Response Status: ${response.statusCode}');
      print('Active Jobs Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          final List<dynamic> jobsList = jsonResponse['data'] ?? [];
          activeJobs.value =
              jobsList.map((job) => JobModel.fromJson(job)).toList();
          print('Active Jobs Loaded: ${activeJobs.length}');
        }
      } else {
        print('Failed to fetch active jobs: ${response.statusCode}');
        Get.snackbar('Error', 'Failed to load jobs');
      }
    } catch (e) {
      print('Exception in _fetchActiveJobs: $e');
      Get.snackbar('Error', 'Error loading jobs: $e');
    } finally {
      isLoadingActiveJobs.value = false;
    }
  }

  /// Fetch jobs with status 'completed' (for Completed tab)
  Future<void> _fetchCompletedJobs() async {
    print('[EmployerHomeController] _fetchCompletedJobs() started');
    try {
      isLoadingCompletedJobs.value = true;
      final accessToken = await SharedPreferenceHelper().getAccessToken();

      if (accessToken == null) {
        Get.snackbar('Error', 'Access token not found');
        return;
      }

      final response = await http.get(
        Uri.parse(
          ApiEndpoint.baseUrl +
              ApiEndpoint.getMyPostedJobsHomeScreen('completed', 1, 10)
                  .replaceFirst(ApiEndpoint.baseUrl, ''),
        ),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
      );

      print('Completed Jobs Response Status: ${response.statusCode}');
      print('Completed Jobs Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        if (jsonResponse['success'] == true) {
          final List<dynamic> jobsList = jsonResponse['data'] ?? [];
          completedJobs.value =
              jobsList.map((job) => JobModel.fromJson(job)).toList();
          print('Completed Jobs Loaded: ${completedJobs.length}');
        }
      } else {
        print('Failed to fetch completed jobs: ${response.statusCode}');
        Get.snackbar('Error', 'Failed to load jobs');
      }
    } catch (e) {
      print('Exception in _fetchCompletedJobs: $e');
      Get.snackbar('Error', 'Error loading jobs: $e');
    } finally {
      isLoadingCompletedJobs.value = false;
    }
  }

  // --- Toggle Favourite (only for Completed Jobs) ---
  void toggleFavourite(int index) {
    if (selectedCategory.value == 'Completed') {
      final job = completedJobs[index];
      if (favouriteJobIds.contains(job.id)) {
        favouriteJobIds.remove(job.id);
      } else {
        favouriteJobIds.add(job.id);
      }
      completedJobs.refresh();
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
}
