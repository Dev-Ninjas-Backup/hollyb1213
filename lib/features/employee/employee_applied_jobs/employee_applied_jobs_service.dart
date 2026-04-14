import 'package:get/get.dart';
import 'package:readytowork/core/common/constants/api_endpoint.dart';
import 'package:readytowork/core/common/share_preferrance/share_preferrance_helper.dart';


class EmployeeAppliedJobsService extends GetConnect {
  EmployeeAppliedJobsService() {
    onInit();
  }

  @override
  void onInit() {
    httpClient.baseUrl = ApiEndpoint.baseUrl;
    httpClient.timeout = const Duration(seconds: 30);
    super.onInit();
  }

  Future<Response> getAppliedJobs() async {
    final token = await SharedPreferenceHelper().getAccessToken();
    return await get(
      ApiEndpoint.employeeAppliedJobs,
      headers: {'Authorization': 'Bearer ${token ?? ''}'},
    );
  }
}
