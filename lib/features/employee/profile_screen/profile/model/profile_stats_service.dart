import 'package:get/get.dart';
import 'package:hollyb1213/core/common/constants/api_endpoint.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:http/http.dart' as http;

class ProfileStatsService extends GetxService {
  Future<http.Response> getEmployeeStats() async {
    final accessToken = await SharedPreferenceHelper().getAccessToken();
    if (accessToken == null) {
      throw Exception('Access token not found');
    }

    final response = await http.get(
      Uri.parse(ApiEndpoint.employeeStats),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );
    return response;
  }
}
