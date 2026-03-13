import 'dart:developer';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:hollyb1213/features/message/model/message_model.dart';
import 'package:hollyb1213/features/message/service/employee_message_service.dart';
import 'package:hollyb1213/features/message/service/rest_message_service.dart';
import 'package:intl/intl.dart';

class MessageController extends GetxController {
  final EmployeeMessageService _socketService = EmployeeMessageService();
  final RestMessageService _restService = RestMessageService();
  final SharedPreferenceHelper _prefs = SharedPreferenceHelper();

  var messages = <MessageModel>[].obs;
  var searchQuery = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchConversations();
    _initializeSocketListener();
  }

  Future<void> fetchConversations() async {
    try {
      isLoading.value = true;

      final token = await _prefs.getAccessToken();

      if (token == null || token.isEmpty) {
        log("Auth token not found, can't fetch messages.");
        isLoading.value = false;
        return;
      }

      // Use REST Service
      final response = await _restService.getConversations(token);

      List list = [];
      if (response.containsKey('data') &&
          response['data'] is Map &&
          response['data'].containsKey('data')) {
        list = response['data']['data'] as List;
      }

      messages.value = list.map((e) {
        final participant = e["participant"] ?? {};
        final lastMessage = e["lastMessage"] ?? {};
        final sender = lastMessage["sender"] ?? {};

        // Date Formatting
        String formattedDate = "";
        String? rawDate = lastMessage["updatedAt"] ?? lastMessage["createdAt"];
        if (rawDate != null && rawDate.isNotEmpty) {
          try {
            final dt = DateTime.parse(rawDate).toLocal();
            formattedDate = DateFormat('hh:mm a').format(dt);
          } catch (_) {
            formattedDate = rawDate;
          }
        }

        return MessageModel(
          conversationId: e["conversationId"] ?? "",
          recipientId: participant["id"] ?? "",
          name: participant["full_name"] ?? "Unknown User",
          company: sender["role"] ?? "Employer", // Mapping Role
          message: lastMessage["content"] ?? "",
          timeAgo: formattedDate,
          imageUrl: "",
          isOnline: false,
        );
      }).toList();

      isLoading.value = false;
    } catch (e) {
      log("Conversation fetch error: $e");
      isLoading.value = false;
    }
  }

  Future<void> _initializeSocketListener() async {
    // Only connecting socket for potential real-time updates, handled separately
    final token = await _prefs.getAccessToken();
    if (token != null) {
      _socketService.connect(token);
    }
  }

  List<MessageModel> get filteredMessages {
    if (searchQuery.value.isEmpty) {
      return messages;
    }

    return messages
        .where((m) =>
            m.name.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
            m.company.toLowerCase().contains(searchQuery.value.toLowerCase()))
        .toList();
  }

  @override
  void onClose() {
    _socketService.disconnect();
    super.onClose();
  }
}
