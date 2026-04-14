import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:readytowork/core/common/constants/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MarkAsCompleteService {
  Future<Map<String, dynamic>> markAsComplete(String jobId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final String? token = prefs.getString('access_token') ??
          prefs.getString('accessToken') ??
          prefs.getString('token');

      if (token == null) {
        return {'success': false, 'message': 'Authentication token not found'};
      }

      final Uri url = Uri.parse(
          '${ApiEndpoint.baseUrl}${ApiEndpoint.markAsComplete(jobId)}');

      final http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('MarkAsComplete Response Status: ${response.statusCode}');
      print('MarkAsComplete Response Body: ${response.body}');

      final Map<String, dynamic> body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message':
              body['message'] ?? 'Shift marked as completed successfully',
        };
      } else {
        return {
          'success': false,
          'message': body['message'] ?? 'Failed to mark as complete'
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'An error occurred: $e'};
    }
  }
}
