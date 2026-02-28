import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeHomeService extends GetConnect {
  Future<Response> getLatestJobs() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('accessToken');

    return await get(
      '${ApiEndpoint.baseUrl}${ApiEndpoint.employeeLatestJobs}',
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
  }
}
