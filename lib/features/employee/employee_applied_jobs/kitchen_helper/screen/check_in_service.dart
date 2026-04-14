import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:readytowork/core/common/constants/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckInService {
  Future<Map<String, dynamic>> checkIn(String jobId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      // We found the correct key is 'access_token' from your logs
      final String? token = prefs.getString('access_token') ??
          prefs.getString('accessToken') ??
          prefs.getString('access_token');

      if (token == null) {
        return {'success': false, 'message': 'Authentication token not found'};
      }

      final Uri url =
          Uri.parse('${ApiEndpoint.baseUrl}${ApiEndpoint.checkIn(jobId)}');

      final http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('CheckIn Response Status: ${response.statusCode}');
      print('CheckIn Response Body: ${response.body}');

      final Map<String, dynamic> body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message': body['message'] ?? 'Checked in successfully'
        };
      } else {
        return {
          'success': false,
          'message': body['message'] ?? 'Failed to check in'
        };
      }
    } catch (e) {
      print('CheckIn Error: $e');
      return {'success': false, 'message': 'An error occurred: $e'};
    }
  }
}
