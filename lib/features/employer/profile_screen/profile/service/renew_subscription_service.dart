// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:hollyb1213/core/common/constants/api_endpoint.dart';

class RenewSubscriptionService {
  Future<http.Response> renewSubscription({
    required String accessToken,
    required String subscriptionId,
    required String paymentMethodId,
  }) async {
    try {
      print('[RenewSubscriptionService] Attempting to renew subscription');
      print('[RenewSubscriptionService] Subscription ID: $subscriptionId');

      final body = jsonEncode({
        'subscriptionId': subscriptionId,
        'paymentMethodId': paymentMethodId,
      });

      print('[RenewSubscriptionService] Request Body: $body');

      final response = await http.post(
        Uri.parse(ApiEndpoint.baseUrl + ApiEndpoint.employerRenewSubscription),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
        },
        body: body,
      );

      print(
          '[RenewSubscriptionService] Response Status Code: ${response.statusCode}');
      print('[RenewSubscriptionService] Response Body: ${response.body}');

      return response;
    } catch (e) {
      print('[RenewSubscriptionService] Exception: $e');
      rethrow;
    }
  }
}
