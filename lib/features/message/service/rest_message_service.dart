import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:hollyb1213/core/common/constants/api_endpoint.dart';

class RestMessageService {
  Future<Map<String, dynamic>> getConversations(String token) async {
    try {
      final uri =
          Uri.parse("${ApiEndpoint.baseUrl}${ApiEndpoint.conversations}");

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        log("Failed to fetch conversations: ${response.statusCode}");
        return {};
      }
    } catch (e) {
      log("REST API Error: $e");
      return {};
    }
  }
}
