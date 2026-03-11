import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hollyb1213/core/common/constants/api_endpoint.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';

class RestNotificationService {
  final _prefsHelper = SharedPreferenceHelper();

  Future<List<Map<String, dynamic>>> getNotifications() async {
    // Note: This assumes getUserId() exists in your SharedPreferenceHelper to retrieve the logged-in user's ID.
    final accessToken = await _prefsHelper.getAccessToken();
    final userId = await _prefsHelper.getUserId();

    if (accessToken == null || userId == null) {
      throw Exception('User not authenticated');
    }

    final response = await http.get(
      Uri.parse(ApiEndpoint.getUserNotifications(userId)),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    print("Notification Response : ${response.body}");

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      if (jsonResponse['success'] == true && jsonResponse['data'] is List) {
        final dataList = jsonResponse['data'] as List;
        if (dataList.isNotEmpty && dataList.first['notifications'] is List) {
          final notificationsList = dataList.first['notifications'] as List;

          // Flatten the structure for easier use in the UI
          return notificationsList.map((item) {
            final notificationDetails =
                item['notification'] as Map<String, dynamic>? ?? {};
            return {
              'id': item['id'], // This is the UserNotification ID
              'read': item['read'] ?? false,
              'title': notificationDetails['title'] ?? 'No Title',
              'message': notificationDetails['message'] ?? 'No Message',
              'createdAt': notificationDetails['createdAt'] ?? '',
              'type': notificationDetails['type'] ?? '',
              'meta': notificationDetails['meta'] ?? {},
            };
          }).toList();
        }
      }
      return []; // Return empty list if data is not in the expected format
    } else {
      throw Exception('Failed to load notifications: ${response.statusCode}');
    }
  }

  Future<void> markNotificationAsRead(String notificationId) async {
    final accessToken = await _prefsHelper.getAccessToken();
    if (accessToken == null) {
      throw Exception('User not authenticated');
    }

    final response = await http.patch(
      Uri.parse(ApiEndpoint.markNotificationAsRead(notificationId)),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception(
          'Failed to mark notification as read: ${response.statusCode}');
    }
  }
}
