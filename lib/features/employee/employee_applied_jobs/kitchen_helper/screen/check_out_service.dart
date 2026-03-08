import 'dart:convert';
import 'package:hollyb1213/core/common/constants/api_endpoint.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CheckOutService {
  Future<Map<String, dynamic>> checkOut(String jobId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      final String? token = prefs.getString('access_token') ??
          prefs.getString('accessToken') ??
          prefs.getString('token');

      if (token == null) {
        return {'success': false, 'message': 'Authentication token not found'};
      }

      final Uri url =
          Uri.parse('${ApiEndpoint.baseUrl}${ApiEndpoint.checkOut(jobId)}');

      final http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('CheckOut Response Status: ${response.statusCode}');
      print('CheckOut Response Body: ${response.body}');

      final Map<String, dynamic> body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          'success': true,
          'message': body['message'] ?? 'Checked out successfully',
          'data': body['data']
        };
      } else {
        return {
          'success': false,
          'message': body['message'] ?? 'Failed to check out'
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'An error occurred: $e'};
    }
  }
}
