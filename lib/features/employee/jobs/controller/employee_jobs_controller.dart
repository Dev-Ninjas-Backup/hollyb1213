import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:readytowork/features/employee/home/screen/job_model.dart';
import 'package:readytowork/features/employee/jobs/screen/employee_jobs_service.dart';


class EmployeeJobsController extends GetxController {
  final EmployeeJobsService _service = EmployeeJobsService();
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
      debugPrint("Jobs API Response: ${response.body}");
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.body['success'] == true) {
          final List<dynamic> data = response.body['data'] ?? [];
          jobsList.value = data
              .map((json) => Job.fromJson(json as Map<String, dynamic>))
              .toList();
        }
      } else {
        debugPrint(
            'Failed to fetch jobs: ${response.statusText} (${response.statusCode})');
      }
    } catch (e) {
      debugPrint('Error fetching jobs: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
