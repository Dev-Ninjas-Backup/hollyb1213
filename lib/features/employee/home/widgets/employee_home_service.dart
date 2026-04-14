import 'package:get/get.dart';
import 'package:readytowork/core/common/constants/api_endpoint.dart';
import 'package:readytowork/core/common/share_preferrance/share_preferrance_helper.dart';


class EmployeeHomeService extends GetConnect {
  Future<Response> getLatestJobs() async {
    final String? token = await SharedPreferenceHelper().getAccessToken();
    final response = await get(
      '${ApiEndpoint.baseUrl}${ApiEndpoint.employeeLatestJobs}',
      headers: {
        'Authorization': 'Bearer ${token ?? ''}',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    // ignore: avoid_print
    print('Latest Jobs API Response: ${response.body}');
    return response;
  }
}
