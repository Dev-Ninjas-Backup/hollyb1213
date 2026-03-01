import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/iconpath.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:hollyb1213/features/employee/home/widgets/employee_home_service.dart';

class EmployeHomeController extends GetxController {
  final EmployeeHomeService service = Get.put(EmployeeHomeService());
  final SharedPreferenceHelper prefs = SharedPreferenceHelper();
  var isLoading = false.obs;
  var latestJobs = <dynamic>[].obs;
  var quickActions = <Map<String, dynamic>>[].obs;

  var headerTitle = "Find Your Perfect Job".obs;
  var headerSubtitle = "Explore thousands of job opportunities".obs;

  @override
  void onInit() {
    super.onInit();
    _initQuickActions();
    getLatestJobs();
  }

  void _initQuickActions({int available = 0, int applied = 0}) {
    quickActions.assignAll([
      {
        "title": "Available Jobs",
        "subtitle": "$available Jobs",
        "icon": Iconpath.job,
        "height": 50.0,
        "width": 50.0
      },
      {
        "title": "Applied Jobs",
        "subtitle": "$applied Jobs",
        "icon": Iconpath.job,
        "height": 50.0,
        "width": 50.0
      },
    ]);
  }

  Future<void> getLatestJobs() async {
    isLoading.value = true;
    try {
      final response = await service.getLatestJobs();
      if (response.statusCode == 200) {
        final body = response.body;
        if (body != null && body['success'] == true) {
          var jobs = body['data'];
          if (jobs != null && jobs is List) {
            latestJobs.assignAll(jobs);
          }
          final stats = body['stats'];
          if (stats != null) {
            _initQuickActions(
              available: stats['availableJobs'] ?? 0,
              applied: stats['appliedJobs'] ?? 0,
            );
          }
        }
      } else if (response.statusCode == 401) {
        // print("Unauthorized access - 401 received. Logging out.");
        // await _prefs.clearAll();
        // Get.offAllNamed(AppRoute.loginScreen);
      } else {
        print('Failed to fetch latest jobs: ${response.statusText}');
      }
    } catch (e) {
      print('Error fetching latest jobs: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
