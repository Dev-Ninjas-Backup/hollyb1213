import 'dart:developer';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';
import 'package:hollyb1213/features/message/model/message_model.dart';
import 'package:hollyb1213/features/employee/chat/service/employee_chat_service.dart';
import 'package:hollyb1213/features/message/service/rest_message_service.dart';
import 'package:intl/intl.dart';

class MessageController extends GetxController {
  final EmployeeChatService _socketService = EmployeeChatService();
  final RestMessageService _restService = RestMessageService();
  final SharedPreferenceHelper _prefs = SharedPreferenceHelper();

  var messages = <MessageModel>[].obs;
  var searchQuery = ''.obs;
  var isLoading = false.obs;
  String? currentUserId;

  @override
  void onInit() {
    super.onInit();
    fetchConversations();
    _initializeSocketListener();
  }

  Future<void> fetchConversations({bool showLoading = true}) async {
    try {
      if (showLoading) isLoading.value = true;

      final token = await _prefs.getAccessToken();

      if (token == null || token.isEmpty) {
        log("Auth token not found, can't fetch messages.");
        if (showLoading) isLoading.value = false;
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
          unreadCount: e['unread_count'] ?? 0,
        );
      }).toList();

      if (showLoading) isLoading.value = false;
    } catch (e) {
      log("Conversation fetch error: $e");
      if (showLoading) isLoading.value = false;
    }
  }

  Future<void> _initializeSocketListener() async {
    final token = await _prefs.getAccessToken();
    currentUserId = await _prefs.getUserId();
    if (token != null) {
      log("Socket: Connecting to message socket...");
      _socketService.connect(token);

      // Listen for new messages to trigger live updates
      _socketService.listenNewMessage((data) {
        log("Socket: New message received with data: $data");
        _updateConversationFromSocket(data);
      });
    } else {
      log("Socket: Token is null. Cannot connect.");
    }
  }

  void _updateConversationFromSocket(dynamic data) {
    try {
      if (data is! Map<String, dynamic> ||
          !data.containsKey('conversationId')) {
        log("Socket: Received message with unexpected data format, refreshing list as a fallback.");
        fetchConversations(showLoading: false);
        return;
      }

      final String conversationId = data['conversationId'];
      final int index =
          messages.indexWhere((c) => c.conversationId == conversationId);

      if (index != -1) {
        // An existing conversation was found, update it locally.
        final MessageModel existing = messages[index];

        String formattedDate = existing.timeAgo;
        final rawDate = data["updatedAt"] ?? data["createdAt"];
        if (rawDate is String && rawDate.isNotEmpty) {
          formattedDate =
              DateFormat('hh:mm a').format(DateTime.parse(rawDate).toLocal());
        }

        int unread = existing.unreadCount;
        if (currentUserId != null &&
            data['sender'] != null &&
            data['sender']['id'] != currentUserId) {
          unread++;
        }

        final updated = MessageModel(
          conversationId: existing.conversationId,
          recipientId: existing.recipientId,
          name: existing.name,
          company: existing.company,
          message: data['content'] ?? existing.message,
          timeAgo: formattedDate,
          imageUrl: existing.imageUrl,
          isOnline: existing.isOnline,
          unreadCount: unread,
        );

        messages.removeAt(index);
        messages.insert(0, updated);
        messages.refresh();
        log("Socket: Updated conversation $conversationId locally and moved to top.");
      } else {
        // This is a new conversation. Fetch the full list to get all details.
        log("Socket: New message for a new conversation, refreshing list.");
        fetchConversations(showLoading: false);
      }
    } catch (e) {
      log("Socket: Error processing new message data: $e. Refreshing list as a fallback.");
      fetchConversations(showLoading: false);
    }
  }

  void resetUnreadCount(String conversationId) {
    final int index =
        messages.indexWhere((c) => c.conversationId == conversationId);
    if (index != -1) {
      final MessageModel existing = messages[index];
      if (existing.unreadCount == 0) return; // No update needed

      final updated = MessageModel(
        conversationId: existing.conversationId,
        recipientId: existing.recipientId,
        name: existing.name,
        company: existing.company,
        message: existing.message,
        timeAgo: existing.timeAgo,
        imageUrl: existing.imageUrl,
        isOnline: existing.isOnline,
        unreadCount: 0, // Reset to zero
      );
      messages[index] = updated;
      log("Reset unread count for conversation $conversationId");
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
