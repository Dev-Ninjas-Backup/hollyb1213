import 'dart:convert';
import 'package:hollyb1213/core/common/constants/api_endpoint.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class JobDetailsService {
  Future<Map<String, dynamic>> getJobDetails(String jobId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('access_token') ??
          prefs.getString('accessToken') ??
          prefs.getString('token');

      if (token == null) {
        return {'success': false, 'message': 'Authentication token not found'};
      }

      final Uri url = Uri.parse(
          '${ApiEndpoint.baseUrl}${ApiEndpoint.employeeJobDetails(jobId)}');

      final http.Response response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('JobDetails Response Status: ${response.statusCode}');
      print('JobDetails Response Body: ${response.body}');

      final Map<String, dynamic> body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return {'success': true, 'data': body['data']};
      } else {
        return {
          'success': false,
          'message': body['message'] ?? 'Failed to fetch details'
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'An error occurred: $e'};
    }
  }
}
