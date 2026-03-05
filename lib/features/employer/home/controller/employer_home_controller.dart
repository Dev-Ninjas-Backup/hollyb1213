import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/core/common/constants/imagepath.dart';
import 'package:hollyb1213/core/common/constants/api_endpoint.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';
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
  final activeJobs = <Map<String, dynamic>>[].obs;
  final completedJobs = <Map<String, dynamic>>[].obs;

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
  RxList<Map<String, dynamic>> get filteredJobs =>
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
          activeJobs.value = jobsList.map((job) {
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
              'id': job['id'] ?? '',
              'image': imageUrl,
              'title': job['title'] ?? 'Job Title',
              'subtitle': job['company_name'] ?? 'Company',
              'distance': job['location'] ?? 'Location',
              'urgent': job['is_urgent'] ?? false,
              'status': job['status'] ?? 'open',
              '_count': job['_count'] ?? {},
              'applicants': job['_count']?['job_applications'] ?? 0,
              'amount': job['amount'] ?? '0',
              'isFavourite': false.obs,
            };
          }).toList();
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
          completedJobs.value = jobsList.map((job) {
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
              'id': job['id'] ?? '',
              'image': imageUrl,
              'title': job['title'] ?? 'Job Title',
              'subtitle': job['company_name'] ?? 'Company',
              'distance': job['location'] ?? 'Location',
              'urgent': job['is_urgent'] ?? false,
              'status': job['status'] ?? 'completed',
              '_count': job['_count'] ?? {},
              'applicants': job['_count']?['job_applications'] ?? 0,
              'amount': job['amount'] ?? '0',
              'isFavourite': false.obs,
            };
          }).toList();
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
      job['isFavourite'].toggle();
      completedJobs.refresh();
    }
  }
}
