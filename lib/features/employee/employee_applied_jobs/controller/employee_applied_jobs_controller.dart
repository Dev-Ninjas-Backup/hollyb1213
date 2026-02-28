import 'package:get/get.dart';
import 'package:hollyb1213/features/employee/employee_applied_jobs/employee_applied_jobs_service.dart';

class EmployeeAppliedJobsController extends GetxController {
  final EmployeeAppliedJobsService _service = EmployeeAppliedJobsService();
  var isLoading = false.obs;
  var appliedJobsList = <dynamic>[].obs;

  var activeJobs = <dynamic>[].obs;
  var completedJobs = <dynamic>[].obs;
  var selectedTab = 0.obs;

  @override
  void onInit() {
    super.onInit();
    if (appliedJobsList.isEmpty) {
      getAppliedJobs();
    }
  }

  Future<void> getAppliedJobs() async {
    isLoading.value = true;
    activeJobs.clear();
    completedJobs.clear();
    try {
      final response = await _service.getAppliedJobs();
      if (response.statusCode == 200) {
        if (response.body['success'] == true) {
          appliedJobsList.value = response.body['data'] ?? [];
          _filterJobsByStatus();
        }
      } else {
        print('Failed to fetch applied jobs: ${response.statusText}');
      }
    } catch (e) {
      print('Error fetching applied jobs: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void _filterJobsByStatus() {
    for (var job in appliedJobsList) {
      final status = (job['status'] as String?)?.toLowerCase();
      if (status == 'completed' || status == 'paid') {
        completedJobs.add(job);
      } else {
        activeJobs.add(job);
      }
    }
  }
}
