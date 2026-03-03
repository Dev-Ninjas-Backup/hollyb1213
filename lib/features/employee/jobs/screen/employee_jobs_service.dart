import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/api_endpoint.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';

class EmployeeJobsService extends GetConnect {
  // Ensure onInit is called when instantiated directly
  EmployeeJobsService() {
    onInit();
  }

  @override
  void onInit() {
    httpClient.baseUrl = ApiEndpoint.baseUrl;
    httpClient.timeout = const Duration(seconds: 30);
    super.onInit();
  }

  Future<Response<dynamic>> getJobs() async {
    final token = await SharedPreferenceHelper().getAccessToken();
    final response = await get(
      ApiEndpoint.employeeJobs,
      headers: {'Authorization': 'Bearer ${token ?? ''}'},
    );
    // ignore: avoid_print
    print('Get Jobs API Response: ${response.body}');
    return response;
  }

  Future<Response> getJobDetails(String jobId) async {
    final token = await SharedPreferenceHelper().getAccessToken();
    final response = await get(
      ApiEndpoint.employeeJobDetails(jobId),
      headers: {'Authorization': 'Bearer ${token ?? ''}'},
    );
    // ignore: avoid_print
    print('Get Job Details API Response for job $jobId: ${response.body}');
    return response;
  }
}
