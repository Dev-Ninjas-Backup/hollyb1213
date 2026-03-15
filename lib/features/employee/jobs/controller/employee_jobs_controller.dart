import 'package:get/get.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:hollyb1213/features/employee/home/screen/job_model.dart';
import 'package:hollyb1213/features/employee/jobs/screen/employee_jobs_service.dart';

class EmployeeJobsController extends GetxController {
  final EmployeeJobsService _service = EmployeeJobsService();
  final SharedPreferenceHelper _prefs = SharedPreferenceHelper();
  var isLoading = false.obs;
  var jobsList = <Job>[].obs;

  @override
  void onInit() {
    super.onInit();
    getJobs();
  }

  Future<void> getJobs() async {
    isLoading.value = true;
    try {
      final response = await _service.getJobs();
      print("Jobs API Response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.body['success'] == true) {
          final List<dynamic> data = response.body['data'] ?? [];
          jobsList.value = data
              .map((json) => Job.fromJson(json as Map<String, dynamic>))
              .toList();
        }
      } else {
        print(
            'Failed to fetch jobs: ${response.statusText} (${response.statusCode})');
      }
    } catch (e) {
      print('Error fetching jobs: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
