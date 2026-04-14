import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:readytowork/core/common/constants/api_endpoint.dart';
import 'package:readytowork/core/common/share_preferrance/share_preferrance_helper.dart';

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
