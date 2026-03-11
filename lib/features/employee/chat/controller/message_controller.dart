import 'dart:developer';
import 'package:get/get.dart';
import 'package:hollyb1213/core/common/share_preferrance/share_preferrance_helper.dart';
import '../model/message_model.dart';
import '../service/employee_message_service.dart';

class MessageController extends GetxController {
  final EmployeeMessageService _service = EmployeeMessageService();
  final SharedPreferenceHelper _prefs = SharedPreferenceHelper();

  var messages = <MessageModel>[].obs;
  var searchQuery = ''.obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeSocket();
  }

  Future<void> _initializeSocket() async {
    try {
      isLoading.value = true;

      final token = await _prefs.getAccessToken();

      if (token == null || token.isEmpty) {
        log("Auth token not found, can't connect to message socket.");
        isLoading.value = false;
        return;
      }

      _service.connect(token);

      _service.listenConversations((data) {
        List list;

        if (data is Map && data.containsKey('conversations')) {
          list = data['conversations'] as List;
        } else if (data is List) {
          list = data;
        } else {
          list = [];
        }

        messages.value = list.map((e) {
          final participant = e["participant"] ?? {};
          final lastMessage = e["lastMessage"] ?? {};

          return MessageModel(
            conversationId: e["conversationId"] ?? "",
            recipientId: participant["id"] ?? "",
            name: participant["full_name"] ?? "Unknown User",
            company: "Employer", // This data is not in the response
            message: lastMessage["content"] ?? "",
            timeAgo: lastMessage["createdAt"] ??
                "", // This is a timestamp, not "time ago"
            imageUrl:
                "", // This data is not in the response, which causes the image error.
            isOnline: false, // This data is not in the response
          );
        }).toList();

        isLoading.value = false;
      });

      _service.loadConversations();
    } catch (e) {
      log("Conversation socket error: $e");
      isLoading.value = false;
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
    _service.disconnect();
    super.onClose();
  }
}
