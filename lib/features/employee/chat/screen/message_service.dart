import 'package:get/get.dart';
import 'package:readytowork/core/common/constants/api_endpoint.dart';
import 'package:readytowork/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:readytowork/features/employee/chat/screen/conversation_model.dart';

class MessageService extends GetConnect {
  final SharedPreferenceHelper _prefs = SharedPreferenceHelper();

  MessageService() {
    httpClient.baseUrl = ApiEndpoint.baseUrl;
    httpClient.addRequestModifier<dynamic>((request) async {
      final token = await _prefs.getAccessToken();
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      return request;
    });
  }

  /// Fetches a conversation by its ID.
  ///
  /// Returns [ConversationData] on success.
  /// Throws an [Exception] if the request fails or the data is invalid.
  Future<ConversationData> getConversation(String conversationId) async {
    final response =
        await get(ApiEndpoint.getConversationDetails(conversationId));

    if (response.isOk && response.body['success'] == true) {
      try {
        return ConversationResponse.fromJson(response.body).data;
      } catch (e) {
        throw Exception('Failed to parse conversation data: $e');
      }
    }
    throw Exception(
        'Failed to load conversation: ${response.body['message'] ?? response.statusText}');
  }
}
