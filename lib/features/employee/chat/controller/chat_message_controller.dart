import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:readytowork/core/common/share_preferrance/share_preferrance_helper.dart';
import '../model/chat_message_model.dart';
import '../service/employee_chat_service.dart';

class EmployeeChatController extends GetxController {
  final EmployeeChatService _service = EmployeeChatService();
  final SharedPreferenceHelper _prefs = SharedPreferenceHelper();

  final String conversationId;
  final String recipientId;

  EmployeeChatController(
      {required this.conversationId, required this.recipientId});

  final textController = TextEditingController();
  final scrollController = ScrollController();

  var messages = <ChatMessage>[].obs;
  var isLoading = true.obs;
  String? currentUserId;

  @override
  void onInit() {
    super.onInit();
    _initChat();
  }

  Future<void> _initChat() async {
    try {
      isLoading.value = true;
      currentUserId = await _prefs.getUserId();
      final token = await _prefs.getAccessToken();

      if (token == null || token.isEmpty) {
        log("Token not found. Cannot connect chat socket.");
        isLoading.value = false;
        return;
      }

      _service.connect(token);

      _service.listenMessages((data) {
        if (data is Map && data.containsKey('messages')) {
          final List list = data["messages"] ?? [];
          messages.value = list
              .map((e) {
                final senderId = e['sender']?['id'] as String?;
                return ChatMessage(
                  message: e["content"] ?? "",
                  isSentByMe: senderId != null && senderId == currentUserId,
                  time: e["createdAt"] ?? "",
                );
              })
              .toList()
              .reversed
              .toList();
        }
        isLoading.value = false;
        _scrollToBottom(jump: true);
      });

      _service.listenNewMessage((data) {
        final senderId = data['sender']?['id'] as String?;
        final newMessage = ChatMessage(
          message: data["content"] ?? "",
          isSentByMe: senderId != null && senderId == currentUserId,
          time: data["createdAt"] ?? "",
        );
        messages.insert(0, newMessage);
        _scrollToBottom();
      });

      _service.loadConversation(conversationId);
    } catch (e) {
      log("Chat initialization error: $e");
      isLoading.value = false;
    }
  }

  void sendMessage() {
    final text = textController.text.trim();
    if (text.isEmpty) return;

    _service.sendMessage(recipientId, text);
    textController.clear();
  }

  void _scrollToBottom({bool jump = false}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        final position = scrollController.position.minScrollExtent;
        if (jump) {
          scrollController.jumpTo(position);
        } else {
          scrollController.animateTo(position,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut);
        }
      }
    });
  }

  @override
  void onClose() {
    _service.disconnect();
    textController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
